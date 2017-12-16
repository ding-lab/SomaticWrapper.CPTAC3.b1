Driver scripts for CPTAC3 Batch 1 SomaticWrapper analyses 

* All project and system-specific paths are defined here
* Invokes scripts in SomaticWrapper.workflow to perform analysis

DATAD is "/gscmnt/gc2521/dinglab/mwyczalk/somatic-wrapper-data"
 - this maps to /data in container

All output will go into $DATAD/CPTAC3.b1.  Dirs there:
 - data - where SomaticWrapper writes stuff
 - config
 - launch 
 - log-lsf


# examples
Start parsing all jobs which are ready to be parsed: 

./evaluate_status.c3b1.sh -e -f parsing_ready_to_start -u | ./run_step.c3b1.sh -S parse -
