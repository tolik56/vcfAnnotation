#! /bin/bash

# Run ExAC query and collect data in separated files

echo "type\effect" > $TMP/typeEff
grep -v ^#  $TMP/$1 | while read line
do
   echo $line | tr ';' '\n' | grep ANN | tr ',' '\n' | gawk -f rankSnp.awk >> $TMP/typeEff
done
