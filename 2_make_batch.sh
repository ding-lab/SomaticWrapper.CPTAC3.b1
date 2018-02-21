# Read BamMap and create batch file which lists runs associated with this batch
# Parses BamMap and incoporates all cases there into CPTAC3.b1.WXS batch 
# Format of batch file: TSV with comments, columns:
#   * Case (e.g., C3L-00004)
#   * RUN_NAME (e.g., C3L-00004.WXS)
#       It is assumed that tumor, normal SampleName in BamMap can be constructed from RUN_NAME
#   * IMPORTD_H: the path that will map to /import in the container.  Can vary between runs 
#       If it is not specified explicitly, it is generated from the longest common prefix of the tumor and somatic paths

source sw.config.sh

# Return the longest common path prefix
# Usage: 
#   get_lcs /path/to/file1 /path/to/file2
# returns 
#   /path/to
# Both files should exist, warning if they do not

function get_lcs {
    # To do: option to suppress existence check
    if [ ! -e $1 ]; then
        >&2 echo Warning: File $1 does not exist
    #    exit 1
    fi

    if [ ! -e $2 ]; then
        >&2 echo Warning: File $2 does not exist
    #    exit 1
    fi

    # This incantation from https://unix.stackexchange.com/questions/67078/decomposition-of-path-specs-into-longest-common-prefix-suffix
    printf "$1\n$2\n" | sed -e 's,$,/,;1{h;d;}' -e 'G;s,\(.*/\).*\n\1.*,\1,;h;$!d;s,/$,,'
}

mkdir -p $(dirname $CASES)
rm -f $CASES

while read CASE; do 
#    [[ $l = \#* ]] && continue

    RUN_NAME="$CASE.$EXPSTR"
    # BamMap columns: 
    # SampleName	Case	Disease	ExpStrategy	SampType	DataPath	DataFormat	Reference	UUID
    # From knowledge of how SampleName put together, we know that normal BAM has name e.g. C3L-00010.WXS.N, tumor analogous
    # SampleNames defined in get_SN here: https://github.com/ding-lab/CPTAC3.case.discover/blob/master/merge_submitted_reads.sh

    # Bam paths relative to host
    BAM_N_H=$(grep "${RUN_NAME}.N" $BAMMAP_H | cut -f 6)
    BAM_T_H=$(grep "${RUN_NAME}.T" $BAMMAP_H | cut -f 6)

    if [ -z $IMPORT_H_EXPLICIT ]; then
        # Obtain IMPORTD_H dynamically from common subdirectory of tumor, normal sample
        # This will be stored in the importd.dat file for use when launching jobs
        IMPORTD_H=$(get_lcs $BAM_N_H $BAM_T_H)
    else 
        IMPORTD_H=$IMPORTD_H_EXPLICIT
    fi

    printf "$CASE\t$RUN_NAME\t$IMPORTD_H_EXPLICIT\n" >> $CASES

done < <(grep -v "^#" $BAMMAP_H | cut -f 2 | sort -u)

echo Written to $CASES

