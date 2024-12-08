#include <iostream>
#include <math.h>
#include <time.h>
#include "mytime.h"

//function to add two elements
void add(int n, float *x, float *y)
{
    for (int i = 0; i < n; i++)
    {
        y[i] = x[i] + y[i];
    }
}

int main()
{
    int N = 1<<29; //1M elements
    struct timespec start, end;

    float *x = new float[N];  
    float *y = new float[N];

    for(int i = 0; i < N; i++)
    {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    start = get_timespec();
    //Run on CPU
    add(N, x, y);
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
    delete [] x;
    delete [] y;

    return 0;
}