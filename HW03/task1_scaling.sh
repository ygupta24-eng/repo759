#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -t 0-00:20:00
#SBATCH -J task1_hw3
#SBATCH -o task1_hw3.out
#SBATCH -e task1_hw3.err
#SBATCH -c 20
 
# Compile on the compute node so the binary always matches the source
g++ task1.cpp matmul.cpp -Wall -O3 -std=c++17 -o task1 -fopenmp
 
if [ ! -x ./task1 ]; then
    echo "ERROR: task1 failed to compile." >&2
    exit 1
fi
 
# One line per run: "t time_ms"
DATA_FILE=task1_data.txt
> "$DATA_FILE"
 
n=1024
for t in $(seq 1 20); do
    output=$(./task1 "$n" "$t")
    time_ms=$(echo "$output" | sed -n '3p')
    echo "$t $time_ms" >> "$DATA_FILE"
done
 
echo "Done. Results in $DATA_FILE"