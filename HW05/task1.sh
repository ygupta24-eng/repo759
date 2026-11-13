#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -t 0-00:05:00
#SBATCH -J task1_hw5
#SBATCH -o task1_hw5.out
#SBATCH -e task1_hw5.err
#SBATCH --gpus-per-task=1

module load nvidia/cuda
nvcc task1.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task1
./task1