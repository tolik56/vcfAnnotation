#! /bin/bash

# Prepare SnpEff annotation

# cd ~/snpEff
# java -Xmx4g -jar snpEff.jar -v -stats ex1.html GRCh37.75 ~/Projects/vcfAnn/Challenge_data.vcf > ~/Projects/vcfAnn/Challenge_data.ann.vcf

# Run ExAC query and collect data in separated files

/bin/rm -f typeEff

grep -v ^#  Challenge_data.ann.vcf | while read line
do
   echo $line | tr ';' '\n' | grep ANN | tr ',' '\n' | gawk -f rankSnp.awk > typeEff
done
