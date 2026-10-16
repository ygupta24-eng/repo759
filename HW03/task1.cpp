#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <omp.h>
#include <random>
 
#include "matmul.h"
 
int main(int argc, char* argv[]) {
    std::size_t n = std::atol(argv[1]);
    int t = std::atoi(argv[2]);
 
    float* A = new float[n * n];
    float* B = new float[n * n];
    float* C = new float[n * n];
 
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<float> dist(-10.0f, 10.0f);
 
    for (std::size_t i = 0; i < n * n; i++) {
        A[i] = dist(gen);
        B[i] = dist(gen);
    }
 
    omp_set_num_threads(t);
 
    std::chrono::high_resolution_clock::time_point start = std::chrono::high_resolution_clock::now();
    mmul(A, B, C, n);
    std::chrono::high_resolution_clock::time_point end = std::chrono::high_resolution_clock::now();
 
    std::chrono::duration<double, std::milli> duration_ms = end - start;
 
    printf("%f\n", C[0]);
    printf("%f\n", C[n * n - 1]);
    printf("%f\n", duration_ms.count());
 
    delete[] A;
    delete[] B;
    delete[] C;
 
    return 0;
}