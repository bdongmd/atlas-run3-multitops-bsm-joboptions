#!/bin/bash

#SBATCH -N 1
#SBATCH -c 4
#SBATCH -t 7-00:00:00

## First, setup environment
source /mnt/home/qianron1/research/atlas-run3-multitops-bsm-joboptions/setup.sh

sh run.sh $1 $2 $3 $4 $5


# The following lines print out a few lines of simple text, and then system
# information to your batch file output.  This can be useful for debugging.
echo ' '
echo '------------------------------' 
echo ' '
scontrol show job $SLURM_JOB_ID     # write job information to output file
