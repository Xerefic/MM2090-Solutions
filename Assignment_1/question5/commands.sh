#!/bin/bash

# Unzipping the text files
tar -xvzf mm2090-apr2021-attendance.tar.gz
mv mm2090-apr2021-attendance/ attendance/
rm *.csv

mkdir sorted

# Grepping just the name and the roll number from every message
lectures=0;
for files in `ls attendance/`;
do
	lectures=$(( $lectures+1 ));
	cat attendance/$files | grep -oe '^\(.*\)..20b...:' > sorted/$(basename $files .sbv).txt
done;

rm -r attendance/

# Seperating the name and roll number
for files in `ls sorted/`;
do
	cat sorted/$files | sed -e 's/\(.*\) \(.*\):/\2, \1/g'  > sorted/$(basename $files .txt).csv
done;
rm sorted/*.txt

# Removing duplicate instances using the wrapper duplicates.awk
mkdir data
for files in `ls sorted/`;
do
	./duplicates.awk < sorted/$files > data/$(basename $files .csv).csv
done;

rm -r sorted/

# Combining the attendance data of all classes
tail -n+1 -q data/*.csv > final.csv

rm -r data/

# Counting the occurence of roll numbers using the wrapper roll.awk
./roll.awk < final.csv > cache1.csv
sort -k1 -n -t, cache1.csv > cache2.csv

# Printing the data and percentage of attendance
cat cache2.csv | awk -v total=$lectures 'BEGIN{printf("Roll,Name,Attendance,Percentage\n");}{ct=$NF/total*100; printf("%s, %.2f\%\n", $0, ct);}' > Attendance.csv

rm cache1.csv
rm cache2.csv
rm final.csv

cat Attendance.csv
