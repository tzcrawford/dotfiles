#!/bin/sh
# Takes some subsection of pages of pdf file and makes a new file. Preserves quality and OCR of source.
# usage:
#   pdf-split.sh input.pdf first_page last_page output.pdf

gs -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$4" -dFirstPage=$2 -dLastPage=$3 -sDEVICE=pdfwrite "$1"
