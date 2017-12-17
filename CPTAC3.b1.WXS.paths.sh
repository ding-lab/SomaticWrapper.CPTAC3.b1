PROJECT="CPTAC3.b1.WXS"

SWW_HOME="SomaticWrapper.workflow"  # Relative directory, since it is a submodule

DATAD_H="/gscmnt/gc2521/dinglab/mwyczalk/somatic-wrapper-data"


# This is the analysis base.  
SCRIPTD_H="$DATAD_H/$PROJECT"
SCRIPTD_C="/data/$PROJECT"

CONFIGD_H="$SCRIPTD_H/config"
CASES="$SCRIPTD_H/$PROJECT.batch"

BAMMAP_H="/gscuser/mwyczalk/projects/CPTAC3/import.CPTAC3b1/BamMap/CPTAC3.b1.WXS.BamMap.dat"

SWDATA_C="$SCRIPTD_C/data"  # where SomaticWrapper data is written, relative to continer
CONFIGD_C="$SCRIPTD_C/config"
