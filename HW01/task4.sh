#!/usr/bin/env bash
#SBATCH -p instruction
#SBATCH -t 0-00:05:00
#SBATCH -J FirstSlurm
#SBATCH -o FirstSlurm.out
#SBATCH -e FirstSlurm.err
#SBATCH -c 2

hostname