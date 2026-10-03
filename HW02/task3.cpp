#include "matmul.h"
#include <cstdio>
#include <random>
#include <chrono>
#include <vector>

int main()
{
    const unsigned int n = 1000;

    std::vector<double> A(n*n);
    std::vector<double> B(n*n);
    double* C = new double[n*n];

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dist(-10.0, 10.0);

    for(unsigned int i=0; i < n*n; i++)
    {
        A[i] = dist(gen);
        B[i] = dist(gen);
    }

    printf("%u\n", n);

    std::chrono::high_resolution_clock::time_point start,end;
    std::chrono::duration<double, std::milli> duration_ms;

    //mmul1
    start = std::chrono::high_resolution_clock::now();
    mmul1(A.data(), B.data(), C, n);
    end = std::chrono::high_resolution_clock::now();
    duration_ms = end - start;
    printf("%f\n", duration_ms.count());
    printf("%f\n", C[n * n - 1]);

    //mmul2
    start = std::chrono::high_resolution_clock::now();
    mmul2(A.data(), B.data(), C, n);
    end = std::chrono::high_resolution_clock::now();
    duration_ms = end - start;
    printf("%f\n", duration_ms.count());
    printf("%f\n", C[n * n - 1]);

    //mmul3
    start = std::chrono::high_resolution_clock::now();
    mmul3(A.data(), B.data(), C, n);
    end = std::chrono::high_resolution_clock::now();
    duration_ms = end - start;
    printf("%f\n", duration_ms.count());
    printf("%f\n", C[n * n - 1]);

    //mmul4
    start = std::chrono::high_resolution_clock::now();
    mmul4(A, B, C, n);
    end = std::chrono::high_resolution_clock::now();
    duration_ms = end - start;
    printf("%f\n", duration_ms.count());
    printf("%f\n", C[n * n - 1]);

    delete[] C;

    return 0;
}