# Read BamMap and create batch file which lists runs associated with this batch
# Parses BamMap and incoporates all cases there into CPTAC3.b1.WXS batch 
# Format of batch file: TSV with comments, columns:
#   * Case (e.g., C3L-00004)
#   * RunName (aka Sample Name, e.g., C3L-00004.WXS)

source sw.config.sh

RUN_GROUP="WXS"  # appended after Case to make run name

mkdir -p $(dirname $CASES)
rm -f $CASES

while read CASE; do 

RUN_NAME="$CASE.$RUN_GROUP"
printf "$CASE\t$RUN_NAME\n" >> $CASES

done < <(grep -v "^#" $BAMMAP_H | cut -f 2 | sort -u)

echo Written to $CASES
