#!/bin/sh
# Converts a pdf to one with searchable text (OCR)
# Also applies a check that proper packages are installed on Arch Linux systems.
# Warning: this script may delete any files named image-* in this directory.

# usage:
#   pdf-OCR.sh input.pdf

#If imagemagick fails to convert pdf to jpg due to a security policy, follow guide here: 
#https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
#add:
#<policy domain="coder" rights="read | write" pattern="PDF" />
#before </policymap> in /etc/ImageMagick-7/policy.xml

#Checking if necessary software is installed (only if Arch Linux)
if lsb_release -a | grep "Arch Linux" > /dev/null; then
    for package in tesseract tesseract-data-eng ghostscript imagemagick ; do
        if ! pacman -Qi tesseract > /dev/null; then
            echo $package is not installed! Installing now.
            sudo pacman -S $package
        fi
    done
fi

#Convert the pdf to a series of high quality images
magick convert -verbose -density 300 "$1" -quality 100 image-%0003d.jpg

for i in ./image-*.jpg; do
    tesseract "$i" "$i" pdf
done

#Combine all of the pdf files into one
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.pdf image-*.pdf

#Remove all of the files not needed anymore
rm image-*.jpg
rm image-*.pdf
