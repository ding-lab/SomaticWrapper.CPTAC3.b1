#!/bin/bash

# Usage: start_run.c3b1.sh [options] -S STEP SN [SN2 ...]

# Start given step(s) for given sample names

# This is a wrapper around SomaticWrapper.workflow/src/run_step.sh with CPTAC3.b1-specific setup added for convenience
# All arguments passed to here will be passed to start_step.sh

# LSF_GROUP must be set as environment variable with e.g.,
# export LSF_GROUP="/mwyczalk/gdc-download"

# All options are passed as-is to SomaticWrapper.workflow:run_step.sh

# Note that -S STEP is required
#
# If SN is - then read SN from STDIN

source CPTAC3.b1.paths.sh

if [ ! -z $LSF_GROUP ]; then
    LSF_GROUP_ARG="-g $LSF_GROUP"
fi

# This is specific to MGI
MGI="-M"

# for MGI, run the working copy of SomaticWrapper in ~/SomaticWrapper/somaticwrapper rather than
# /usr/local/somaticwrapper which is in the image.  This will let SW use the latest version of 
# code without needing github/dockerhub rev.  Note that this is possible on MGI because _H paths
# also visible in container
SW_HOME_C="/gscuser/mwyczalk/projects/SomaticWrapper/somaticwrapper"

#DOCKERHOST="-h blade18-2-9.gsc.wustl.edu"  # reuse same host for testing purposes so image loading is faster

# Arguments to run_step.sh, for convenience
    # Usage: start_step.sh [options] SN [SN2 ...]
    # -D DATAD: path to base of data directory, which maps to /data in container. Required
    # -s SCRIPTD: Logs and scripts will be written to $SCRIPTD/logs and /launch, respectively.  Required
    # -p SWW_HOME: Must be set with -p or SWW_HOME environment variable.
    # -w SW_HOME_C: default [/usr/local/somaticwrapper]
    # -c CONFIGD: default [/data/config].  Configuration file is $CONFIGD/$SN.config
    #
    # Other arguments
    # -S: step.  Must be one of "run", "parse", "merge", "vep", or a step number \(e.g. "1"\).  Required
    # -d: dry run.  This may be repeated (e.g., -dd or -d -d) to pass the -d argument to called functions instead, 
    #     with each called function called in dry run mode if it gets one -d, and popping off one and passing rest otherwise
    # -g LSF_GROUP: LSF group to use starting job
    # -M: MGI environment.  Non-MGI environment currently not implemented
    # -B: Run BASH in Docker instead of gdc-client
    # -m mGb: requested memory in Gb (requires numeric step, e.g. '1')

ARGS="-D $DATAD_H -s $SCRIPTD_H -p $SWW_HOME -c $CONFIGD_C -w $SW_HOME_C $LSF_GROUP_ARG $MGI $DOCKERHOST"

bash $SWW_HOME/src/run_step.sh $ARGS "$@"
