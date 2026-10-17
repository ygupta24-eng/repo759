#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -t 0-00:20:00
#SBATCH -J task3_t
#SBATCH -o task3_t.out
#SBATCH -e task3_t.err
#SBATCH -c 20
#SBATCH --hint=nomultithread
 
# Set this to the ts value with the lowest time in task3_ts.pdf
BEST_TS=512
 
g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
if [ ! -x ./task3 ]; then echo "ERROR: task3 failed to compile." >&2; exit 1; fi
 
# One line per run: "t time_ms", n = 10^6
DATA_FILE=task3_t_data.txt
> "$DATA_FILE"
for t in $(seq 1 20); do
    output=$(./task3 1000000 "$t" "$BEST_TS")
    time_ms=$(echo "$output" | sed -n '3p')
    echo "$t $time_ms" >> "$DATA_FILE"
done
echo "Done. Results in $DATA_FILE"