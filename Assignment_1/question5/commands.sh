#!/bin/bash

tar -xvzf mm2090-apr2021-attendance.tar.gz
mv mm2090-apr2021-attendance/ attendance/
rm *.csv

mkdir sorted

lectures=0;
for files in `ls attendance/`;
do
	lectures=$(( $lectures+1 ));
	cat attendance/$files | grep -oe '..20b...:' > sorted/$(basename $files .sbv).txt
done;

for files in `ls sorted/`;
do
	cat sorted/$files | sed -e 's/\(.*\):/\1/g' > sorted/$(basename $files .txt).csv
done;
rm sorted/*.txt

mkdir data
for files in `ls sorted/`;
do
	./duplicates.awk < sorted/$files > data/$(basename $files .csv).csv
done;

rm -r attendance/
rm -r sorted/

tail -n+1 -q data/*.csv > final.csv

./roll.awk < final.csv > cache1.csv
sort -k1 -n -t, cache1.csv > cache2.csv

cat cache2.csv | awk -v total=$lectures 'BEGIN{print total}{ct=$2/total*100; printf("%s,%f\n", $1, ct);}' > attendance.csv

rm cache1.csv
rm cache2.csv
rm final.csv
rm -r data/

cat attendance.csv
