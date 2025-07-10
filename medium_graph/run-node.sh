#!/bin/bash

#SBATCH --job-name=try
#SBATCH --output=~/jobs/job-%j.out

#SBATCH --gres=gpu:A100:1
#SBATCH --partition=gpu
#SBATCH --time=10000

JOBDATADIR=`ws create work --space "$SLURM_JOB_ID" --duration "7 00:00:00"`
JOBTMPDIR=/tmp/job-"$SLURM_JOB_ID"

srun mkdir -p "$JOBDATADIR" "$JOBTMPDIR"/models
DIRECTORY=~
srun --container-image=projects.cispa.saarland:5005#c01cema/container:vc2 --container-mounts="$JOBTMPDIR":/tmp $DIRECTORY/trampoline-one.sh "$DIRECTORY" "$@"

srun mv "$JOBTMPDIR"/ "$JOBDATADIR"/data
