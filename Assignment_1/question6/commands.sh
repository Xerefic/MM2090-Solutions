#!/bin/bash

echo "Choosing element number 32 Ge with Atomic Radius 1.25 pm"
echo "Criterion is 10% deviance in Atomic Radius from the chosen element"
./radius.awk < AtomicRadii.csv > Similar.csv
cat Similar.csv
