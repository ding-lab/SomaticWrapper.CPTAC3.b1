#!/bin/bash

# Start given step(s) for given UUIDs. 

# This is a wrapper around SomaticWrapper.workflow/src/run_step.sh with CPTAC3.b1-specific setup added for convenience
# All arguments passed to here will be passed to start_step.sh

# LSF_GROUP must be set as environment variable with e.g.,
# export LSF_GROUP="/mwyczalk/gdc-download"

# Usage: start_run.c3b1.sh [options] STEP UUID [UUID2 ...]
# All options except the following are passed as-is to SomaticWrapper.workflow:run_step.sh
#
# If UUID is - then read UUID from STDIN

# Data download location
DATA_DIR="/Users/mwyczalk/Data/SomaticWrapper/data"

# Where logs and launch scripts are written
SCRIPTD="/foo/bar"

# Where SomaticWrapper.workflow is installed
export SWW_HOME="/Users/mwyczalk/Data/SomaticWrapper/SomaticWrapper.workflow"


mkdir -p $DATA_DIR

if [ ! -z $LSF_GROUP ]; then
    LSF_GROUP_ARG="-g $LSF_GROUP"
fi

STEP=$1; shift

bash $SWW_HOME/src/run_step.sh -D $DATA_DIR -s $SCRIPTD -S $STEP $LSF_GROUP_ARG -s import "$@"
