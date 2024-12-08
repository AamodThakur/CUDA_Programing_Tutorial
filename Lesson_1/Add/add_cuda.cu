#include <iostream>
#include <math.h>
#include <time.h>
#include <cuda.h>
#include "mytime.h"

//function to add two elements
//Every function meant for cuda is written by global
__global__
void add(int n, float *x, float *y)
{
    //index =  blockidx.x * blockDim.x + threadIdx.x
    int index = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i+= stride)
    {
        y[i] = x[i] + y[i];
    }
}

int main()
{
    int N = 1<<3; //1M elements
    struct timespec start, end;

    float *x, *y;
    
    //allocate data in unified memory 
    cudaMallocManaged(&x, N*sizeof(float));
    cudaMallocManaged(&y, N*sizeof(float));



    for(int i = 0; i < N; i++)
    {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    //Get device configuration
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, 0); // Replace 0 with your device ID if needed

    printf("Max threads per block: %d\n", prop.maxThreadsPerBlock);
    printf("Max threads per dimension (x, y, z): %d, %d, %d\n", 
            prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
    printf("Max grid size (x, y, z): %d, %d, %d\n", 
            prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);



    //It is very volatile, make sure numBlocks is not in decimals/float. It should be fully divisible, to prevent miscalculation.
    int blockSize = 1024;       //1024 because thats's maximum thread per block
    int numBlocks = (N + blockSize - 1)/blockSize;

    std::cout << N << std::endl << numBlocks << std::endl;

    start = get_timespec();
    //Run on GPU; Launch the kernel to execute the function on GPU
    //add<<<1,256>>>(N, x, y);
    add<<<numBlocks,blockSize>>>(N, x, y);

    //Is the lauched kernel is async, we are waiting here for kerenl to finish it's job.
    cudaDeviceSynchronize();
    cudaError_t err = cudaGetLastError();

    if (err != cudaSuccess) 
    {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }

    end = get_timespec();

    std::cout << "Time Taken(ms): " << diff_timespec_us(start, end)/1000 << std::endl;

    //Check errors, all values are 3.0f
    float max_error = 0.0f;
    for(int i = 0; i < N; i++)
    {
        max_error = fmax(max_error, fabs(y[i]-3.0f));
        std::cout << y[i] << ", ";
    }
    std::cout << std::endl;
    std::cout << "Max Error:" << max_error << std::endl;

    //Free Memory
    cudaFree(x);
    cudaFree(y);

    return 0;
}