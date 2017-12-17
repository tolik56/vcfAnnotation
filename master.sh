#! /bin/bash

export TMP=/tmp/Ann

FILENAME=$1
TABLE=$2
# FILENAME=/Users/anatoly/Projects/vcfAnn/Challenge_data.vcf
# TABLE=/Users/anatoly/Projects/vcfAnn/table.tsv

FILE=$(basename "$FILENAME")

mkdir --parents $TMP

# Prepare SnpEff annotation
( cd ~/snpEff; java -Xmx4g -jar snpEff.jar GRCh37.75 $FILENAME > $TMP/$FILE )

# Get ExAC annotation
./getExacAnn.sh $FILE

# Find most significan variant effect
./getSnpEff.sh $FILE

# Calculate counts
gawk -f calcCount.awk $TMP/$FILE > $TMP/countAnn

#Prepare a report
( cd $TMP; grep -v '^##' $FILE | cut -f 1,2,4,5 | paste - alfqExac fltrExac typeEff countAnn ) > $TABLE

