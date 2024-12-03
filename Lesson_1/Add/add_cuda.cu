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
    for (int i = 0; i < n; i++)
    {
        y[i] = x[i] + y[i];
    }
}

int main()
{
    int N = 1<<25; //1M elements
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

    start = get_timespec();
    //Run on GPU; Launch the kernel to execute the function on GPU
    add<<<1,1>>>(N, x, y);

    //Is the lauched kernel is async, we are waiting here for kerenl to finish it's job.
    cudaDeviceSynchronize();

    end = get_timespec();

    std::cout << "Time Taken(ms): " << diff_timespec_us(start, end)/1000 << std::endl;

    //Check errors, all values are 3.0f
    float max_error = 0.0f;
    for(int i = 0; i < N; i++)
    {
        max_error = fmax(max_error, fabs(y[i]-3.0f));
    }
    std::cout << "Max Error:" << max_error << std::endl;

    //Free Memory
    cudaFree(x);
    cudaFree(y);

    return 0;
}