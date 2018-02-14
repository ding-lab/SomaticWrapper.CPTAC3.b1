#!/bin/bash

# Usage: start_batch_run.sh [options] -S STEP SN [SN2 ...]

# Start given step(s) for given sample names

# This is a wrapper around SomaticWrapper.workflow/run_step.sh with batch-specific setup added for convenience
# All arguments passed to here will be passed to start_step.sh

# LSF_GROUP must be set as environment variable with e.g.,
# export LSF_GROUP="/mwyczalk/gdc-download"

# All options are passed as-is to SomaticWrapper.workflow:run_step.sh

# Note that -S STEP is required
#
# If SN is - then read SN from STDIN

source sw.config.sh

if [ ! -z $LSF_GROUP ]; then
    LSF_GROUP_ARG="-g $LSF_GROUP"
fi

# This is specific to MGI
MGI="-M"

# for MGI, run the working copy of SomaticWrapper in ~/SomaticWrapper/somaticwrapper rather than
# /usr/local/somaticwrapper which is in the image.  This will let SW use the latest version of 
# code without needing github/dockerhub rev.  Note that this is possible on MGI because _H paths
# also visible in container
#SW_HOME_C="/gscuser/mwyczalk/projects/SomaticWrapper/SomaticWrapper.CPTAC3.b1/SomaticWrapper.workflow/somaticwrapper"

# In regular docker environment, core somaticwrapper is sub-submodule
SW_HOME_C="SomaticWrapper.workflow/somaticwrapper"

# IMPORTD_H is the directory which maps to /import and which contains the BAM files.  It is determined
# dynamically (to allow for heterogenous partitions in BamMap for one batch), and is stored in the 
# file IMPORTD_H.  This file is created when the configuration files are made

ARGS="-D $DATAD_H -T $IMPORTD_DAT -I $IMAGED_H -s $SCRIPTD_H -p $SWW_HOME -c $CONFIGD_C -w $SW_HOME_C $LSF_GROUP_ARG $MGI $DOCKERHOST"

bash $SWW_HOME/run_step.sh $ARGS "$@"
