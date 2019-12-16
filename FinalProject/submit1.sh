#!/bin/bash -l

# Use the staclass partition. Only applies if you are in STA141C
#SBATCH --partition=staclass

# Use two cores to get some pipeline parallelism
#SBATCH --cpus-per-task=2

# Give the job a name
#SBATCH --job-name=hw5_step1

# Email me a result
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lyali@ucdavis.edu

bash selected_columns.sh 