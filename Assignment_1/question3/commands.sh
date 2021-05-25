#!/bin/bash

tar -xvzf screenshots.tar.gz
mkdir cropped

cd screenshots/
for f in *\ *; do mv "$f" "${f// /_}"; done
i=0;
for files in `ls`;
do
	mv $files $(basename $i).png;
	i=$(( $i+1 ));
done;

# convert 0.png -crop 1450x865+1475+40 out.png
cd ..

for files in `ls screenshots/`;
do
	./crop.sh screenshots/$files 1450 865 1475 40;
done;

rm -r screenshots/
mkdir combined

for j in $(seq 0 $(($i/2-1)) );
do
	convert -append cropped/$(basename $(($j*2))).png cropped/$(basename $(($j*2+1))).png combined/$(basename $j).png
done;

rm -r cropped/

convert -page A4 -resize 3508x2480 combined/*.png Screenshots.pdf


rm -r combined/
