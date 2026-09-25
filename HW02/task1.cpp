#include "scan.h"
#include <cstdlib>
#include <cstdio>
#include <random>
#include <chrono>

int main(int argc, char *argv[])
{
    std::size_t n = std::atol(argv[1]);

    float *arr = new float[n];
    float *output = new float[n];

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<float> dist(-1.0f, 1.0f);

    for(std::size_t i=0; i < n; ++i)
    {
        arr[i] = dist(gen);
    }

    std::chrono::high_resolution_clock::time_point start = std::chrono::high_resolution_clock::now();
    scan(arr, output, n);
    std::chrono::high_resolution_clock::time_point end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double,std::milli> duration = end - start;

    printf("Time taken for inclusive scan of %zu elements: %f ms\n", n, duration.count());
    printf("%f\n", output[0]);
    printf("%f\n", output[n-1]);

    delete[] arr;
    delete[] output;

    return 0;
}