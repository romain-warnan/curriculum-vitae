#!/bin/bash

cv_style=${1:-'classic'}
cv_color=${2:-'burgundy'}
cv_filename=cv-${cv_style}-${cv_color}.tex

sed "s/moderncvstyle{classic}/moderncvstyle{${cv_style}}/g" cv.tex > ${cv_filename}
sed -i "s/moderncvcolor{burgundy}/moderncvcolor{${cv_color}}/g" ${cv_filename}

pdflatex -quiet -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf ${cv_filename}

rm ${cv_filename}
rm *.aux
rm *.log
rm *.out
rm *.gz