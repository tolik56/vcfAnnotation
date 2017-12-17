#! /bin/bash

# Extract Allele frequncy and filter status using ExACT API

# Make a file with ExAC queries
gawk '/^[^#]/{OFS="-";print $1,$2,$4,$5}' $TMP/$1 > $TMP/queryExac

# Run ExAC query and collect data in separated files

echo "allele_fq" > $TMP/alfqExac 
echo "filter" > $TMP/fltrExac

for i in $(cat queryExac)
do
  # echo $i
  wget --quiet --output-document - "http://exac.hms.harvard.edu/rest/variant/variant/$i" | tr , '\n' | gawk -F: '/allele_freq/{print $2;f=1}END{if(f!=1)print "NA"}' >> $TMP/alfqExac
  wget --quiet --output-document - "http://exac.hms.harvard.edu/rest/variant/variant/$i" | tr , '\n' | gawk -F: '/"filter"/{print $2;f=1}END{if(f!=1)print "NA"}' >> $TMP/fltrExac
done

