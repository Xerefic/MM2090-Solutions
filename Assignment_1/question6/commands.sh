#!/bin/bash

echo "Choosing element 32 Ge with Atomic Radius 1.25"
./radius.awk < AtomicRadii.csv > Similar.csv
cat Similar.csv
