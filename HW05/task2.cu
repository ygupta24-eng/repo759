#include <cstdio>
#include <cuda_runtime.h>
#include <random>

__global__ void axpyKernel(int *dA, int a) {
    int x = threadIdx.x;
    int y = blockIdx.x;
    dA[blockIdx.x * blockDim.x + threadIdx.x] = a * x + y;
}

int main() {
    const int N = 16;
    int *dA;
    int hA[N];

    cudaMalloc((void **)&dA, N * sizeof(int));

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<int> dist(1, 10);
    int a = dist(gen);

    axpyKernel<<<2, 8>>>(dA, a);
    cudaMemcpy(hA, dA, N * sizeof(int), cudaMemcpyDeviceToHost);

    for (int i = 0; i < N; i++) {
        std::printf("%d", hA[i]);
        if (i != N - 1) std::printf(" ");
    }
    std::printf("\n");

    cudaFree(dA);
    return 0;
}