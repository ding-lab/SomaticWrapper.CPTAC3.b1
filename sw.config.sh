# Batch is unique identifier which refers to all runs which are evaluated together
BATCH="StrelkaDemo"

# The following are used for synthetic BamMap creation
DIS="TEST"    # Disease.  Used only in BamMap
DF="BAM"      # Datafile Format.  Used only in BamMap
REF="GRCh37"  # Reference.  Used only in BamMap
# TODO: incorporate REF definition here with some actions 

# Experimental strategy is used to generate sample names and run names, and is WXS, WGS, or RNA-Seq
# By default, sample name is CASE.EXPSTR.T/N (e.g., C3L-00004.WXS.N), and run_name is CASE.EXPSTR
# It is also included in BamMap
# Sample names refer to specific BAM/FASTQ files and are created for CPTAC3 project workflow here:
#     function get_SN : https://github.com/ding-lab/CPTAC3.case.discover/blob/master/merge_submitted_reads.sh
EXPSTR="WXS"

# SWW_HOME_H is path to SomaticWrapper.workflow.  Ordinarily the workflow is distributed
# as a submodule of this project so the path is ./SomaticWrapper.workflow.  Documentation
# will assume that this is the case unless indicated otherwise, but SWW_HOME_H can be any path
SWW_HOME_H="SomaticWrapper.workflow"  

# DATAD_H is root directory of processing results.  Maps to /data
DATAD_H="$HOME/Data/SomaticWrapper/data"  

# IMAGED_H is where per-image data lives (e.g., reference, databases).  
IMAGED_H="$HOME/Data/SomaticWrapper/image"

# IMPORTD_H can be defined explicitly or dynamically 
# It is defined explicitly below.  Alternatively, comment out line below for dynamic mapping which can be
# different for every tumor/normal pair
IMPORTD_H_EXPLICIT="$HOME/Data/SomaticWrapper/import"

# This is the analysis base.
SCRIPTD_H="$DATAD_H/$BATCH"
SCRIPTD_C="/data/$BATCH"
CONFIGD_H="$DATAD_H/$BATCH/config"
CONFIGD_C="/data/$BATCH/config"

SWDATA_C="$SCRIPTD_C/results"  # where SomaticWrapper results are written, relative to continer

# BAMMAP_H can be uploaded or generated.  
BAMMAP_H="$SCRIPTD_H/$BATCH.BamMap.dat"

# CASES file is generated. Holds case and run names, as well as per-case IMPORTD_H mapping
CASES="$SCRIPTD_H/$BATCH.batch"

# This is what the run configuration file will be based on.
CONFIG_TEMPLATE="$SWW_HOME_H/templates/GRCh37.template"


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
