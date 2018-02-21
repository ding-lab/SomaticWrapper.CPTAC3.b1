# Create run configuration files 

# The configuration file is written to CONFIGD_H directory
#
# For StrelkaDemo testing purposes, set use_vep_db=1 to avoid using VEP cache

source sw.config.sh

# CONFIGD_H defined in CPTAC3.b1.paths
mkdir -p $CONFIGD_H

# path to SomaticWrapper.workflow script
MAKE_CONFIG="$SWW_HOME_H/make_config.py"

# IMPORTDAT_H will let us get the volume BAM/FASTQs per run
rm -f $IMPORTDAT_H

while read LINE; do

    CASE=$(echo "$LINE" | cut -f 1)
    RUN_NAME=$(echo "$LINE" | cut -f 2)
    IMPORTD_H=$(echo "$LINE" | cut -f 3)
    CONFIG_OUT="$CONFIGD_H/${RUN_NAME}.config"

    # BamMap columns: 
    # SampleName	Case	Disease	ExpStrategy	SampType	DataPath	DataFormat	Reference	UUID
    # From knowledge of how SampleName put together, we know that normal BAM has name e.g. C3L-00010.WXS.N, tumor analogous

    # Bam paths relative to host
    BAM_N_H=$(grep "${RUN_NAME}.N" $BAMMAP_H | cut -f 6)
    BAM_T_H=$(grep "${RUN_NAME}.T" $BAMMAP_H | cut -f 6)

    IMPORTD_C="/import"
# https://askubuntu.com/questions/520080/remove-the-first-part-of-a-string-using-sed
    BAM_N_C=$(echo $BAM_N_H | sed "s|$IMPORTD_H\(.*\)|\1|" | sed "s|^|$IMPORTD_C|")
    BAM_T_C=$(echo $BAM_T_H | sed "s|$IMPORTD_H\(.*\)|\1|" | sed "s|^|$IMPORTD_C|")

    # Now create configuration file based on template, with above BAM paths, and RUN_NAME as sample name
    # Fields below will add to or replace those found in template

    # Note that the *config files should be copied to config/params directory, rather than being read from the distribution
    # this is the approach Song Cao takes and should be adopted
    cat <<EOF | python $MAKE_CONFIG -t $CONFIG_TEMPLATE -o $CONFIG_OUT
    sample_name=$RUN_NAME      # FIXME: sample_name in somaticwrapper is inconsistent with sample name in BamPath file
    normal_bam=$BAM_N_C
    tumor_bam=$BAM_T_C
    sw_data=$SWDATA_C
    sw_dir=$SW_HOME_C
    reference_fasta = /image/A_Reference/demo20.fa
    reference_dict = /image/A_Reference/demo20.dict
    pindel_config = $SW_HOME_C/params/pindel.WES.ini
    varscan_config = $SW_HOME_C/params/varscan.WES.ini
    strelka_config = $SW_HOME_C/params/strelka.WES.ini

    # dbsnp_db is specific to reference
    dbsnp_db=/image/B_Filter/dbsnp-StrelkaDemo.noCOSMIC.vcf.gz

    # definitions below are generally for testing
    use_vep_db = 1  # online VEP lookups.  For lightweight use and testing
    output_vep = 1 # Write annotated data in VEP format (rather than VCF) with gene names 
    annotate_intermediate = 1 # VEP-annotate intermediate output files (testing)
EOF

done < $CASES

echo Config files written to $CONFIGD_H

