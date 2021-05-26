#!/bin/bash

tar -xvzf mm2090-apr2021-attendance.tar.gz
mv mm2090-apr2021-attendance/ transcripts/

mkdir registered
lectures=0;
for files in `ls transcripts/`;
do
	lectures=$(( $lectures+1 ));
	cat transcripts/$files | grep -oe '^\(.*\)..20b...:' > registered/$(basename $files .sbv).txt
done;
rm -r transcripts/

for files in `ls registered/`;
do
        cat registered/$files | sed -e 's/\(.*\) \(.*\):/\2,\1/g'  > registered/$(basename $files .txt).csv
done;
rm registered/*.txt


mkdir cache
for files in `ls registered/`;
do
	cat registered/$files | sed -e 's/ /_/g' > cache/$(basename $files .csv).csv
done;	
rm -r registered/

mkdir attendance
for files in `ls cache/`;
do
	cat cache/$files | awk -F, '{name[$1]=$2;}END{for (id in name){printf("%s,%s\n", id, name[id]);}}' | sort -k1 -n > attendance/$(basename $files .csv).csv
done;
rm -r cache/

tail -n+1 -q attendance/*.csv | awk -F, '{name[$1]=$2;}END{for (id in name){printf("%s,%s\n", id, name[id]);}}' | sort -k1 -n > registered.csv

tail -n+1 -q attendance/*.csv | awk -F, -v total=$lectures '{data[$1]=$0;name[$1]++;}END{for (id in name){printf("%s,%.2f\%\n", data[id], name[id]/total*100);}}' | sort -k1 -n > attendance.csv

mkdir absent
for files in `ls attendance/`
do
	diff attendance/$files registered.csv | egrep '....b...' | sed 's/> \(.*\)/\1/g' | awk -v lecture=$(basename $files .csv) '{printf("%s,%s\n", $0, lecture)}' > absent/$(basename $files .csv).csv;
done;	
rm registered.csv
rm -r attendance/

tail -n+1 -q absent/*.csv | awk -F, '{name[$1]=$2;absent[$1]=absent[$1]$3;}END{for (id in name){printf("%s,%s,%s\n", id, name[id], absent[id]);}}' | sort -k1 -n > absent.csv
rm -r absent/

awk -F, 'NR==FNR {absent[$1]=$3; next}{printf("%s,%s\n", $0, absent[$1]);}' absent.csv attendance.csv > cache.csv
rm absent.csv
rm attendance.csv

cat cache.csv | sed 's/_/ /g' > final.csv
rm cache.csv

awk -F, 'BEGIN{printf("Roll,Name,Percentage,Missed Lectures\n");}{print $0;}' < final.csv > Attendance.csv
rm final.csv
