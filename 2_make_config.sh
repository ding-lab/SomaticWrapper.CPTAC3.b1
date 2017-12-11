# Create configuration files for GRCh37 run
# Based on BAM paths for MGI

TEMPLATE="/Users/mwyczalk/Data/SomaticWrapper/SomaticWrapper.workflow/templates/GRCh37.template"
BAMMAP="/Users/mwyczalk/Data/CPTAC3/import.summary/dat.MGI/CPTAC3.b1.WXS.BamMap.dat"
CASES="dat/CPTAC3.b1.WXS.dat"

# Where configuration files go.  This dir will need to be visible from docker container, so will need to be changed/moved
OUTD="sw_config"
mkdir -p $OUTD

# path to SomaticWrapper.workflow script
MAKE_CONFIG="/Users/mwyczalk/Data/SomaticWrapper/SomaticWrapper.workflow/src/make_config.py"

while read LINE; do

    CASE=$(echo "$LINE" | cut -f 1)
    RUN_NAME=$(echo "$LINE" | cut -f 2)
    OUT="$OUTD/${RUN_NAME}.config"

    # BamMap columns: 
    # SampleName	Case	Disease	ExpStrategy	SampType	DataPath	DataFormat	Reference	UUID
    # From knowledge of how SampleName put together, we know that normal BAM has name e.g. C3L-00010.WXS.N, tumor analogous

    BAM_N=$(grep "${RUN_NAME}.N" $BAMMAP | cut -f 6)
    BAM_T=$(grep "${RUN_NAME}.T" $BAMMAP | cut -f 6)

    # Now create configuration file based on template, with above BAM paths, and RUN_NAME as sample name
    cat <<EOF | python $MAKE_CONFIG -t $TEMPLATE -o $OUT
    sample_name=$RUN_NAME
    normal_bam=$BAM_N
    tumor_bam=$BAM_T
EOF

done < $CASES


