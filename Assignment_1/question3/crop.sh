#!/bin/bash

# Cropping the input image into size $2x$3 with strides $4 and $5 and saving it
convert $1 -crop $2x$3+$4+$5 cropped/$(basename $1 .png).png
