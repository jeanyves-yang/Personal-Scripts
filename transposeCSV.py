#import csv
#from itertools import izip
#with open("/work/jbullins/1_DTI_Mullen/BUILDING-CSVS/ML/test/ad_MedialLemniscus_Left-test.csv", "rb") as csvfile:
#   reader=csv.reader(csvfile, delimiter=" ", quotechar=",")
#   a = izip(reader)
#   with open("output.csv", "wb") as f:
#       fileWriter = csv.writer(f, delimiter=' ',quotechar=',', quoting=csv.QUOTE_MINIMAL)
#       for row in zip(a):
#           fileWriter.writerow(row)



#from itertools import izip
#from csv import reader, writer

#with open('/work/jbullins/1_DTI_Mullen/BUILDING-CSVS/ML/test/ad_MedialLemniscus_Left-test.csv') as f:
#    with open('destination.csv', 'w') as fw:
#        writer(fw, delimiter=',').writerows(izip(*reader(f, delimiter=',')))


#!/usr/bin/env python
import csv
import itertools
import sys

# Read all Tab-delimited rows from stdin.
with open("/work/jbullins/1_DTI_Mullen/BUILDING-CSVS/ML/test/fa_MedialLemniscus_Left.csv", "rb") as csvfile:
   tsv_reader = csv.reader(csvfile, delimiter=',')
   all_data = list(tsv_reader)

# Transpose it.
   all_data = list(itertools.izip_longest(*all_data, fillvalue=''))

# Write it back out.
with open("test.csv","wb") as f:
   tsv_writer = csv.writer(f, delimiter=',')
   for row in all_data:
       tsv_writer.writerow(row) 

