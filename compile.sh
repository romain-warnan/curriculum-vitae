#!/bin/bash

usage () {
	echo "Usage:"
	echo "   ./compile.sh [-s style] [-c color]"
	echo
	echo "Available styles:"
	echo "   'casual', 'classic' (default), 'banking', 'oldstyle' and 'fancy'"
	echo "Available colors:"
	echo "   'black', 'blue', 'burgundy' (default), 'green', 'grey', 'orange', 'purple' and 'red'"
	echo
	echo "Examples:"
	echo "   ./compile.sh -s casual -c green"
	echo "   ./compile.sh -s fancy"
	echo "   ./compile.sh -c purple"
	echo "   ./compile.sh"
	exit
}


while getopts ":c:s:" options; do
  case ${options} in
    s) cv_style="$OPTARG"
    ;;
    c) cv_color="$OPTARG"
    ;;
    \?) usage
    ;;
  esac
done

cv_style=${cv_style:-'classic'}
cv_color=${cv_color:-'burgundy'}

printf "Generating PDF: style '%s', color '%s'\n" "$cv_style" "$cv_color"

cv_filename=cv-${cv_style}-${cv_color}.tex

sed "s/moderncvstyle{classic}/moderncvstyle{${cv_style}}/g" cv.tex > ${cv_filename}
sed -i "s/moderncvcolor{burgundy}/moderncvcolor{${cv_color}}/g" ${cv_filename}

pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf ${cv_filename} > /dev/null

rm ${cv_filename}
rm *.aux
rm *.log
rm *.out
rm *.gz

printf "Output written in: cv-%s-%s.pdf\n" "$cv_style" "$cv_color"

