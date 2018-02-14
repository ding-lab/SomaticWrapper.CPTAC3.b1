# Batch is unique identifier which refers to all runs which are evaluated together
BATCH="StrelkaDemo"

# Run Group is an arbitrary string which is used to generate sample names and run names
# By default, sample name is CASE.RUN_GROUP.T/N (e.g., C3L-00004.WXS.N), and run_name is CASE.RUN_GROUP
RUN_GROUP="WXS"

SWW_HOME_H="SomaticWrapper.workflow"  # Relative directory, since it is a submodule
CONFIG_TEMPLATE="$SWW_HOME_H/templates/GRCh37.template"

# DATAD is root directory of processing results.  Maps to /data
#DATAD_H="/gscmnt/gc2521/dinglab/mwyczalk/somatic-wrapper-data"
DATAD_H="/Users/mwyczalk/Data/SomaticWrapper/local/data"  # epazote

# IMAGED_H is where per-image data lives (e.g., reference, filters).  
IMAGED_H="/Users/mwyczalk/Data/SomaticWrapper/local/image.data"

# This is the analysis base.
SCRIPTD_H="$DATAD_H/$BATCH"
SCRIPTD_C="/data/$BATCH"
CONFIGD_H="$DATAD_H/$BATCH/config"
CONFIGD_C="/data/$BATCH/config"

SWDATA_C="$SCRIPTD_C/results"  # where SomaticWrapper results are written, relative to continer

# BAMMAP_H will in general be uploaded or generated - here it is generated
BAMMAP_H="$SCRIPTD_H/$BATCH.BamMap.dat"

# CASES file is generated. 
CASES="$SCRIPTD_H/$BATCH.batch"

# IMPORTDAT_H is created during configuration file creation and allows for dynamic mapping
# of /import directory (this directory contains BAM/FASTQ files).  That is, it let each
# run have its own mapping of /import, which is convenient when importing of data is split
# among multiple disks.  This mapping is created in step 3_create_config.sh
# TODO: this information could be kept in the batch file, which provided per-sample-name information
IMPORTDAT_H="$SCRIPTD_H/importd.dat"



# Define this =1 if in MGI environment
# Define this =0 otherwise
MGI=0

# for MGI, run the working copy of SomaticWrapper in ~/SomaticWrapper/somaticwrapper rather than
# /usr/local/somaticwrapper which is in the image.  This will let SW use the latest version of 
# code without needing github/dockerhub rev.  Note that this is possible on MGI because _H paths
# also visible in container
#SW_HOME_C="$SWW_HOME_H/somaticwrapper"

# In regular docker environment, somaticwrapper is installed in /usr/local
SW_HOME_C="/usr/local/somaticwrapper"
