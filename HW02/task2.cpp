#include "convolution.h"
#include <cstdlib>
#include <cstdio>
#include <random>
#include <chrono>

int main(int argc, char *argv[])
{
    std::size_t n = std::atol(argv[1]);
    std::size_t m = std::atol(argv[2]);

    float *image = new float[n*n];
    float *mask = new float[m*m];
    float *output = new float[n*n];

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<float> image_dist(-10.0f, 10.0f);
    std::uniform_real_distribution<float> mask_dist(-1.0f, 1.0f);

    for(std::size_t i=0; i < n*n; ++i)
    {
        image[i] = image_dist(gen);
    }
    for(std::size_t i=0; i < m*m; ++i)
    {
        mask[i] = mask_dist(gen);
    }

    std::chrono::high_resolution_clock::time_point start = std::chrono::high_resolution_clock::now();

    convolve(image, output, n, mask, m);

    std::chrono::high_resolution_clock::time_point end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double,std::milli> duration = end - start;

    printf("%f\n", duration.count());
    printf("%f\n", output[0]);
    printf("%f\n", output[n*n-1]);

    delete[] image;
    delete[] mask;
    delete[] output;

    return 0;
}