#!/usr/bin/env bash

#SBATCH -p instruction
#SBATCH -t 0-00:45:00
#SBATCH -J task1_scaling
#SBATCH -o task1_scaling.out
#SBATCH -e task1_scaling.err
#SBATCH -c 1
#SBATCH --mem=9G
 
# Output data file: one line per run, "n time_ms"
DATA_FILE=task1_data.txt
> "$DATA_FILE"   # clear/create the file
 
for exp in $(seq 10 30); do
    n=$((2**exp))
    echo "Running n=2^${exp} = ${n}"
    output=$(./task1 "$n")
    time_ms=$(echo "$output" | sed -n '1p')
    echo "$n $time_ms" >> "$DATA_FILE"
done
 
echo "Done. Results in $DATA_FILE"
 