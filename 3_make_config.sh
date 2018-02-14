# Create configuration files for GRCh37 run
# Based on BAM paths for MGI

# NOTE: Data in BamMap has to be visible from within the container under /import directory.  
# Note that different data files may be saved to different partitions, so that there is no per-project import directory.
# Here, we define IMPORTD_H as the common directory of the tumor and normal files, and create container-specific 
# paths accordingly
# Because IMPORTD_H is defined dynamically, we save this information in a separate file IMPORTD_DAT
# the run_step scripts then use this file to map sample name to IMPORTD_H
# 
# The configuration file is written to CONFIGD_H directory

source sw.config.sh

TEMPLATE="$SWW_HOME/templates/GRCh37.template"

# CONFIGD_H defined in CPTAC3.b1.paths
mkdir -p $CONFIGD_H

# path to SomaticWrapper.workflow script
MAKE_CONFIG="$SWW_HOME/make_config.py"

# IMPORTD_DAT will let us get the volume BAM/FASTQs per run
rm -f $IMPORTD_DAT

while read LINE; do

    CASE=$(echo "$LINE" | cut -f 1)
    RUN_NAME=$(echo "$LINE" | cut -f 2)
    CONFIG_OUT="$CONFIGD_H/${RUN_NAME}.config"

    # BamMap columns: 
    # SampleName	Case	Disease	ExpStrategy	SampType	DataPath	DataFormat	Reference	UUID
    # From knowledge of how SampleName put together, we know that normal BAM has name e.g. C3L-00010.WXS.N, tumor analogous

    # Bam paths relative to host
    BAM_N_H=$(grep "${RUN_NAME}.N" $BAMMAP_H | cut -f 6)
    BAM_T_H=$(grep "${RUN_NAME}.T" $BAMMAP_H | cut -f 6)

    # Obtain IMPORTD_H dynamically from common subdirectory of tumor, normal sample
    # This will be stored in the importd.dat file for use when launching jobs
    IMPORTD_H=$(bash get_lcs.sh $BAM_N_H $BAM_T_H)

    >&2 echo Dynamically determined IMPORTD_H: $IMPORTD_H

    IMPORTD_C="/import"
# https://askubuntu.com/questions/520080/remove-the-first-part-of-a-string-using-sed
#    BAM_N_C=$(echo $BAM_N_H | sed 's|.*GDC_import\(.*\)|\1|' | sed "s|^|$IMPORTD_C|")
#    BAM_T_C=$(echo $BAM_T_H | sed 's|.*GDC_import\(.*\)|\1|' | sed "s|^|$IMPORTD_C|")
    BAM_N_C=$(echo $BAM_N_H | sed "s|$IMPORTD_H\(.*\)|\1|" | sed "s|^|$IMPORTD_C|")
    BAM_T_C=$(echo $BAM_T_H | sed "s|$IMPORTD_H\(.*\)|\1|" | sed "s|^|$IMPORTD_C|")

    # Now create configuration file based on template, with above BAM paths, and RUN_NAME as sample name
    # Fields below will add to or replace those found in template
    cat <<EOF | python $MAKE_CONFIG -t $TEMPLATE -o $CONFIG_OUT
    sample_name=$RUN_NAME
    normal_bam=$BAM_N_C
    tumor_bam=$BAM_T_C
    sw_data=$SWDATA_C
    reference_fasta = /image/A_Reference/demo20.fa
    reference_dict = /image/A_Reference/demo20.dict
EOF
    # write out mapping to importd.dat file
    printf "$RUN_NAME\t$IMPORTD_H\n" >> $IMPORTD_DAT
done < $CASES

echo Config files written to $CONFIGD_H
echo /import mapping written to $IMPORTD_DAT

