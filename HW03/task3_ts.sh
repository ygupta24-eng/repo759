#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -t 0-00:20:00
#SBATCH -J task3_ts
#SBATCH -o task3_ts.out
#SBATCH -e task3_ts.err
#SBATCH -c 20
#SBATCH --hint=nomultithread
 
g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
if [ ! -x ./task3 ]; then echo "ERROR: task3 failed to compile." >&2; exit 1; fi
 
# One line per run: "ts time_ms", n = 10^6, t = 8, ts = 2^1 ... 2^10
DATA_FILE=task3_ts_data.txt
> "$DATA_FILE"
for p in $(seq 1 10); do
    ts=$((2**p))
    output=$(./task3 1000000 8 "$ts")
    time_ms=$(echo "$output" | sed -n '3p')
    echo "$ts $time_ms" >> "$DATA_FILE"
done
echo "Done. Results in $DATA_FILE"
 