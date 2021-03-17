#!/bin/sh
# Merges multiple pdfs into one file. Preserves quality and OCR of source.
# usage:
#   pdf-merge.sh output.pdf input1.pdf input2.pdf ....

outputfile="$1" #first parameter
shift #now $2-->$1, $3-->$2 etc
# "$@" means "$1" "$2" ... , "$*" means "$1 $2 $3"

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$outputfile" "$@" 
