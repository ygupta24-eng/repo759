#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -t 0-00:20:00
#SBATCH -J task3_hw5
#SBATCH -o task3_hw5.out
#SBATCH -e task3_hw5.err
#SBATCH -n 1
#SBATCH --gpus-per-task=1

module load nvidia/cuda
nvcc task3.cu vscale.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task3

echo "single run, n = 1024:"
./task3 1024

# Sweep: "n time_512 time_16"
DATA_FILE=task3_data.txt
> "$DATA_FILE"
for p in $(seq 10 29); do
    n=$((2**p))
    t512=$(./task3 "$n" 512 | sed -n '1p')
    t16=$(./task3 "$n" 16 | sed -n '1p')
    echo "$n $t512 $t16" >> "$DATA_FILE"
done
echo "Done. Results in $DATA_FILE"