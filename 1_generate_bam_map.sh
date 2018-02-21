# Initialize configuration for StrelkaDemo
# * Create BamMap file which will drive subsequent analysis
#
# BamMaps are created in the CPTAC3 workflow here:
#   https://github.com/ding-lab/importGDC/blob/master/make_bam_map.sh
# Here we create the relevant fields for the workflow

source sw.config.sh

# The following fields from sw.config.sh are used only here:
# DIS    # Disease
# DF     # Datafile Format
# REF    # Reference


mkdir -p $SCRIPTD_H
rm -f $BAMMAP_H

function write_bam_map_line {
SN=$1  # SampleName
ST=$2  # SampleType
FN=$3  # Path to data file

ARG=""

if [ -z $HEADER_PRINTED ]; then  # write header for first line
    ARG="-H "
    HEADER_PRINTED=1
fi

GBM="$SWW_HOME_H/create_bam_map.sh"

$SWW_HOME_H/create_bam_map.sh $ARG $SN $CASE $DIS $EXPSTR $ST $FN $DF $REF
}


CASE="StrelkaDemoCase"

# BAM files defined below are staged in 0_initialize_StrelkaDemo.sh
write_bam_map_line "$CASE.$EXPSTR.T" "tumor" "$IMPORTD_H_EXPLICIT/$CASE.T.bam" >> $BAMMAP_H
write_bam_map_line "$CASE.$EXPSTR.N" "normal" "$IMPORTD_H_EXPLICIT/$CASE.N.bam" >> $BAMMAP_H

# Add more files as appropriate
# write_bam_map_line "CASE2.$EXPSTR.T" "tumor" "/path/to/tumor.bam" >> $BAMMAP_H
# write_bam_map_line "CASE2.$EXPSTR.N" "normal" "/path/to/normal.bam" >> $BAMMAP_H

echo Written to $BAMMAP_H
