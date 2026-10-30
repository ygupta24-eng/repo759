#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -t 0-00:30:00
#SBATCH -J task4_hw4
#SBATCH -o task4_hw4.out
#SBATCH -e task4_hw4.err
#SBATCH -c 8
#SBATCH --hint=nomultithread

# Build one binary per OpenMP scheduling policy (SCHED macro in task3.cpp)
for s in static dynamic guided; do
    g++ task3.cpp -Wall -O3 -std=c++17 -o task3_$s -fopenmp -DSCHED=$s
    if [ ! -x ./task3_$s ]; then echo "ERROR: task3_$s failed to compile." >&2; exit 1; fi
done

N=500
TEND=100
REPS=3

# One line per (schedule, threads): "schedule t time_ms" (best of REPS runs)
DATA_FILE=task4_data.txt
> "$DATA_FILE"

for s in static dynamic guided; do
    for t in $(seq 1 8); do
        best=""
        for r in $(seq 1 $REPS); do
            ms=$(./task3_$s "$N" "$TEND" "$t" | sed -E 's/^time: ([0-9.eE+-]+)ms$/\1/')
            if [ -z "$best" ] || awk "BEGIN{exit !($ms < $best)}"; then best=$ms; fi
        done
        echo "$s $t $best" >> "$DATA_FILE"
    done
done

echo "Done. Results in $DATA_FILE"