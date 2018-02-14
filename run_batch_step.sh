#!/bin/bash

# Start one step of processing for each given SN (sample/run name).  This is run on host computer
#
# Usage: start_batch_run.sh [options] -S STEP SN [SN2 ...]
#
# This is a wrapper around SomaticWrapper.workflow/run_step.sh with batch-specific setup added for convenience
# All arguments passed to here will be passed to start_step.sh
#
# If SN is - then read SN from STDIN
#
# All options are passed as-is to SomaticWrapper.workflow/run_step.sh
#
# Note that -S STEP is required

# Example for StrelkaDemo: bash run_batch_step.sh -S 1 TestCase.WXS 

source sw.config.sh

if [ ! -z $LSF_GROUP ]; then
    LSF_GROUP_ARG="-g $LSF_GROUP"
fi

if [ $MGI == 1 ]; then
MGI_FLAG="-M"
fi



# IMPORTD_H is the directory which maps to /import and which contains the BAM files.  It is determined
# dynamically (to allow for heterogenous partitions in BamMap for one batch), and is stored in the 
# file IMPORTD_H.  This file is created when the configuration files are made

ARGS="$MGI_FLAG -D $DATAD_H -T $IMPORTDAT_H -I $IMAGED_H -s $SCRIPTD_H -p $SWW_HOME_H -c $CONFIGD_C -w $SW_HOME_C $LSF_GROUP_ARG $DOCKERHOST"

bash $SWW_HOME_H/run_step.sh $ARGS "$@"
