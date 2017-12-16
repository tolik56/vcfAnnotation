#! /bin/bash

# Extract Allele frequncy and filter status using ExACT API

# Make a file with ExAC queries
gawk '/^[^#]/{OFS="-";print $1,$2,$4,$5}' Challenge_data.vcf > queryExac

# Run ExAC query and collect data in separated files

/bin/rm -f alfqExac fltrExac

for i in $(cat queryExac)
do
  echo $i
  wget --quiet --output-document - "http://exac.hms.harvard.edu/rest/variant/variant/$i" | tr , '\n' | gawk -F: '/allele_freq/{print $2;f=1}END{if(f!=1)print "NA"}' >> alfqExac
  wget --quiet --output-document - "http://exac.hms.harvard.edu/rest/variant/variant/$i" | tr , '\n' | gawk -F: '/"filter"/{print $2;f=1}END{if(f!=1)print "NA"}' >> fltrExac
done

