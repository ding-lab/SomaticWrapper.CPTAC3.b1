# Create batch file which lists runs associated with this batch
# Parses BamMap and incoporates all cases there into CPTAC3.b1.WXS batch 
# Format of batch file: TSV with comments, columns:
#   * Case (e.g., C3L-00004)
#   * RunName (aka Sample Name, e.g., C3L-00004.WXS)

source CPTAC3.b1.paths.sh

# CASES_H already defined in CPTAC3.b1.paths.  Simply make that directory
mkdir -p $(dirname $CASES)
rm -f $CASES

while read CASE; do 

RUN_NAME="$CASE.WXS"
printf "$CASE\t$RUN_NAME\n" >> $CASES

done < <(grep -v "^#" $BAMMAP_H | cut -f 2 | sort -u)

echo Written to $CASES
