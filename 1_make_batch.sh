# Create batch file which lists runs associated with this batch
# Parses BamMap and incoporates all cases there into CPTAC3.b1.WXS batch 
# Format of batch file: TSV with comments, columns:
#   * Case (e.g., C3L-00004)
#   * RunName (aka Sample Name, e.g., C3L-00004.WXS)

# This is BamMap for MGI data - ok for current testing purposes
BAMMAP="/Users/mwyczalk/Data/import.CPTAC3b1/BamMap/CPTAC3.b1.WXS.BamMap.dat"

OUTD="dat"
mkdir -p $OUTD
OUT="$OUTD/CPTAC3.b1.WXS.dat"
rm -f $OUT

while read CASE; do 

RUN_NAME="$CASE.WXS"
printf "$CASE\t$RUN_NAME\n" >> $OUT

done < <(grep -v "^#" $BAMMAP | cut -f 2 | sort -u)

echo Written to $OUT
