source sw.config.sh

CASE="TestCase"

DIS="TEST"
ES="WGS"
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
write_bam_map_line "$CASE.$RUN_GROUP.T" "tumor" "/Users/mwyczalk/Data/SomaticWrapper/data/data/SWtest/SWtest.T.bam" >> $BAMMAP_H
write_bam_map_line "$CASE.$RUN_GROUP.N" "normal" "/Users/mwyczalk/Data/SomaticWrapper/data/data/SWtest/SWtest.N.bam" >> $BAMMAP_H

echo Written to $BAMMAP_H
