#include <cstdio>
#include <cstdlib>
#include <cuda_runtime.h>
#include <random>

#include "vscale.cuh"

int main(int argc, char *argv[]) {
    unsigned int n = std::atoi(argv[1]);
    // Optional second argument: threads per block (default 512, as required)
    unsigned int threads = (argc > 2) ? std::atoi(argv[2]) : 512;

    float *hA = new float[n];
    float *hB = new float[n];

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<float> distA(-10.0f, 10.0f);
    std::uniform_real_distribution<float> distB(0.0f, 1.0f);
    for (unsigned int i = 0; i < n; i++) {
        hA[i] = distA(gen);
        hB[i] = distB(gen);
    }

    float *dA, *dB;
    cudaMalloc((void **)&dA, n * sizeof(float));
    cudaMalloc((void **)&dB, n * sizeof(float));
    cudaMemcpy(dA, hA, n * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(dB, hB, n * sizeof(float), cudaMemcpyHostToDevice);

    unsigned int blocks = (n + threads - 1) / threads;

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    vscale<<<blocks, threads>>>(dA, dB, n);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    float ms = 0.0f;
    cudaEventElapsedTime(&ms, start, stop);

    cudaMemcpy(hB, dB, n * sizeof(float), cudaMemcpyDeviceToHost);

    std::printf("%f\n", ms);
    std::printf("%f\n", hB[0]);
    std::printf("%f\n", hB[n - 1]);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    cudaFree(dA);
    cudaFree(dB);
    delete[] hA;
    delete[] hB;
    return 0;
}
