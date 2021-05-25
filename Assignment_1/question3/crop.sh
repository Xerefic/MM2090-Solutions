#!/bin/bash

convert $1 -crop $2x$3+$4+$5 cropped/$(basename $1 .png).png
