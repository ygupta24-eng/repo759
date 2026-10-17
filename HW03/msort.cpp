#include "msort.h"
 
#include <algorithm>
#include <omp.h>
#include <vector>
 
// Sorts arr[lo, hi) using tmp as scratch space.
static void msort_rec(int* arr, int* tmp, std::size_t lo, std::size_t hi, std::size_t threshold) {
    std::size_t len = hi - lo;
    if (len <= threshold || len < 2) {
        // small input: plain serial sort, no more tasks
        std::sort(arr + lo, arr + hi);
        return;
    }
 
    std::size_t mid = lo + len / 2;
 
#pragma omp task shared(arr, tmp)
    msort_rec(arr, tmp, lo, mid, threshold);
 
#pragma omp task shared(arr, tmp)
    msort_rec(arr, tmp, mid, hi, threshold);
 
#pragma omp taskwait
 
    std::merge(arr + lo, arr + mid, arr + mid, arr + hi, tmp + lo);
    std::copy(tmp + lo, tmp + hi, arr + lo);
}
 
void msort(int* arr, const std::size_t n, const std::size_t threshold) {
    if (n < 2) return;
    std::vector<int> tmp(n);
    int* tmp_ptr = tmp.data();
 
#pragma omp parallel
    {
#pragma omp single
        msort_rec(arr, tmp_ptr, 0, n, threshold);
    }
}