# Batch is unique identifier which refers to all runs which are evaluated together
BATCH="CPTAC3.b1.WXS"

# Run Group is an arbitrary string which is used to generate sample names and run names
# By default, sample name is CASE.RUN_GROUP.T/N (e.g., C3L-00004.WXS.N), and run_name is CASE.RUN_GROUP
RUN_GROUP="WXS"

SWW_HOME="SomaticWrapper.workflow"  # Relative directory, since it is a submodule
CONFIG_TEMPLATE="$GWW_HOME/templates/GRCh37.template"

# Processing DATAD is root directory of processing results.  Maps to /data
#PROCESSING_DATAD_H="/gscmnt/gc2521/dinglab/mwyczalk/somatic-wrapper-data"
PROCESSING_DATAD_H="/Users/mwyczalk/Data/SomaticWrapper/data"  # epazote

# IMPORTD_H is parent directory of where BAM/FASTQ files live.  This is typically created by importGDC
# The path below must be the leading path of the path found in the BamMap file, 
# maps to /import
IMPORTD_H="/Users/mwyczalk/Data/SomaticWrapper/data/data"

# This is the analysis base.
SCRIPTD_H="$PROCESSING_DATAD_H/$BATCH"
SCRIPTD_C="/data/$BATCH"
CONFIGD_H="$PROCESSING_DATAD_H/$BATCH/config"
CONFIGD_C="/data/$BATCH/config"

# Is SWDATA necessary?
#SWDATA_C="$SCRIPTD_C/data"  # where SomaticWrapper results are written, relative to continer

# BAMMAP_H will in general be uploaded or generated - here it is generated
BAMMAP_H="$SCRIPTD_H/$BATCH.BamMap.dat"

# CASES file is generated. 
CASES="$SCRIPTD_H/$BATCH.batch"

