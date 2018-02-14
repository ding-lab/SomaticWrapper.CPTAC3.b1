#!/bin/bash

# author: Matthew Wyczalkowski m.wyczalkowski@wustl.edu

# This is a wrapper around importGDC/evaluate_status.sh with CPTAC3.b1-specific setup added for convenience
# All arguments passed to here will be passed to evaluate_status.sh

# Usage from evaluate_status.sh

# Evaluate status of all samples in batch file 
# This is specific to MGI (dependent on LSF-specific output to evaluate status)
# Usage: evaluate_status.sh [options] batch.dat
#
# options
# -f status: output only lines matching status, e.g., -f import:completed
# -u: include only UUID in output

source sw.config.sh

bash $SWW_HOME/evaluate_status.sh -S $SCRIPTD_H "$@" $CASES
