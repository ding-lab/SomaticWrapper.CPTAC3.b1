# Create configuration files for GRCh37 run
# Based on BAM paths for MGI

# NOTE: BAM Paths as obtained from BamMap have to be visible from within the container
# For this to happen,
#   1) import.CPTAC3b1.git has to be modified to write to $DATAD_H/GDC_import
#      (this has already been done at MGI by moving the data)
#   2) We need to remap paths obtained from BamMap to be visible from container; in practice this
#      involves stripping all paths before GDC_import and replacing with /data
#      An alternative way would be for BamMap to list two paths, container- and host-specific

source sw.config.sh

TEMPLATE="$SWW_HOME/templates/GRCh37.template"

# CONFIGD_H defined in CPTAC3.b1.paths
mkdir -p $CONFIGD_H

# path to SomaticWrapper.workflow script
MAKE_CONFIG="$SWW_HOME/src/make_config.py"

while read LINE; do

    CASE=$(echo "$LINE" | cut -f 1)
    RUN_NAME=$(echo "$LINE" | cut -f 2)
    OUT="$CONFIGD_H/${RUN_NAME}.config"

    # BamMap columns: 
    # SampleName	Case	Disease	ExpStrategy	SampType	DataPath	DataFormat	Reference	UUID
    # From knowledge of how SampleName put together, we know that normal BAM has name e.g. C3L-00010.WXS.N, tumor analogous

    # Bam paths relative to host
    BAM_N_H=$(grep "${RUN_NAME}.N" $BAMMAP_H | cut -f 6)
    BAM_T_H=$(grep "${RUN_NAME}.T" $BAMMAP_H | cut -f 6)

    PATH_C="/data/GDC_import"
# https://askubuntu.com/questions/520080/remove-the-first-part-of-a-string-using-sed
    BAM_N_C=$(echo $BAM_N_H | sed 's|.*GDC_import\(.*\)|\1|' | sed "s|^|$PATH_C|")
    BAM_T_C=$(echo $BAM_T_H | sed 's|.*GDC_import\(.*\)|\1|' | sed "s|^|$PATH_C|")

    # Now create configuration file based on template, with above BAM paths, and RUN_NAME as sample name
    # Fields below will add to or replace those found in template
    cat <<EOF | python $MAKE_CONFIG -t $TEMPLATE -o $OUT
    sample_name=$RUN_NAME
    normal_bam=$BAM_N_C
    tumor_bam=$BAM_T_C
    sw_data=$SWDATA_C
EOF
done < $CASES

echo Config files written to $CONFIGD_H

