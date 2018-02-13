source sw.config.sh

CASE="TestCase"

DIS="TEST"
ES="WXS"
DF="BAM"
REF="GRCh37"

function write_bam_map_line {
SN=$1
ST=$2
FN=$3

ARG=""

if [ -z $HEADER_PRINTED ]; then  # write header for first line
    ARG="-H "
    HEADER_PRINTED=1
fi

GBM="$SWW_HOME/create_bam_map.sh"

$SWW_HOME/create_bam_map.sh $ARG $SN $CASE $DIS $ES $ST $FN $DF $REF
}

mkdir -p $SCRIPTD_H
rm -f $BAMMAP_H

# Tumor
# Details: /Users/mwyczalk/Data/SomaticWrapper/SomaticWrapper.CPTAC3.b1/SomaticWrapper.workflow/somaticwrapper/image.setup/S_StrelkaDemoSetup/2_setup_strelka_demo.sh
write_bam_map_line "$CASE.$RUN_GROUP.T" "tumor" "/Users/mwyczalk/Data/SomaticWrapper/data/S_StrelkaTestData/NA12891_demo20.bam" >> $BAMMAP_H
write_bam_map_line "$CASE.$RUN_GROUP.N" "normal" "/Users/mwyczalk/Data/SomaticWrapper/data/S_StrelkaTestData/NA12892_demo20.bam" >> $BAMMAP_H

echo Written to $BAMMAP_H
