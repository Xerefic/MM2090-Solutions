#!/bin/bash

# Unzipping the screenshots
tar -xvzf screenshots.tar.gz
mkdir cropped

# Renaming the files for ease of access
cd screenshots/
for f in *\ *; do mv "$f" "${f// /_}"; done
i=0;
for files in `ls`;
do
	mv $files $(basename $i).png;
	i=$(( $i+1 ));
done;

# size: 1450x865+1475+40
cd ..

# Using the wrapper crop.sh to crop the renamed images
for files in `ls screenshots/`;
do
	./crop.sh screenshots/$files 1450 865 1475 40;
done;

rm -r screenshots/
mkdir combined

# Combining two images into one by appending them vertically
for j in $(seq 0 $(($i/2-1)) );
do
	convert -append cropped/$(basename $(($j*2))).png cropped/$(basename $(($j*2+1))).png combined/$(basename $j).png
done;

rm -r cropped/

# Joining the combined images into a pdf
convert -page A4 -resize 3508x2480 combined/*.png Screenshots.pdf


rm -r combined/
