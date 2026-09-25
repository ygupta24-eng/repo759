#include "convolution.h"

void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m)
{
    int half = static_cast<int>((m-1)/2);

    for(std::size_t x=0; x < n; x++ )
    {
        for(std::size_t y=0; y < n; y++)
        {
            float sum = 0.0f;

            for(std::size_t i=0; i < m; i++)
            {
                for(std::size_t j=0; j < m; j++)
                {
                    int row = static_cast<int>(x) + static_cast<int>(i) - half;
                    int col = static_cast<int>(y) + static_cast<int>(j) - half;

                    bool row_valid = (row >= 0) && (row < static_cast<int>(n));
                    bool col_valid = (col >= 0) && (col < static_cast<int>(n));

                    float f_val;
                    if(row_valid && col_valid)
                    {
                        f_val = image[static_cast<std::size_t>(row) * n + static_cast<std::size_t>(col)];
                    }
                    else if(row_valid || col_valid)
                    {
                        f_val = 1.0f;  //edge handling: if either row or col is valid, use 1.0f
                    }
                    else
                    {
                        f_val = 0.0f;  //edge handling: if both row and col are invalid, use 0.0f
                    }

                    sum += mask[i * m + j] * f_val;
                }
            }

            output[x * n + y] = sum;
        }
    }
}