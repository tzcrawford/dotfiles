#!/bin/sh
# Decreases the size of a pdf file
# usage:
#   pdf-shrink.sh input.pdf ouput.pdf [quality]
#   where quality can be "screen" "ebook" "prepress" "printer" or "default"

#-dPDFSETTINGS=/screen lower quality, smaller size. (72 dpi)
#-dPDFSETTINGS=/ebook for better quality, but slightly larger pdfs. (150 dpi)
#-dPDFSETTINGS=/prepress output similar to Acrobat Distiller "Prepress Optimized" setting (300 dpi)
#-dPDFSETTINGS=/printer selects output similar to the Acrobat Distiller "Print Optimized" setting (300 dpi)
#-dPDFSETTINGS=/default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file

if [ -z "$3" ]; then #third parameter empty, default to ebook quality
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$2" "$1"
else
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$3 -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$2" "$1"
fi
