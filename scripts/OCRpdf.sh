#!/bin/sh
#Converts a pdf to one with searchable text (OCR)
#originally meant for arch systems but technically applicable elsewhere

#If imagemagick fails to convert pdf to jpg due to a security policy, follow guide here: 
#https://stackoverflow.com/questions/52998331/imagemagick-security-policy-pdf-blocking-conversion
#add:
#<policy domain="coder" rights="read | write" pattern="PDF" />
#before </policymap> in /etc/ImageMagick-7/policy.xml

#check if proper packages installed, assuming archlinux
if lsb_release -a | grep "Arch Linux" > /dev/null; then
    if ! pacman -Qi tesseract > /dev/null; then
        sudo pacman -S tesseract
    fi  
    if ! pacman -Qi tesseract-data-eng > /dev/null; then
        sudo pacman -S tesseract-data-eng
    fi  
    if ! pacman -Qi ghostscript > /dev/null; then
        sudo pacman -S ghostscript
    fi  
    if ! pacman -Qi imagemagick > /dev/null; then
        sudo pacman -S imagemagick
    fi  
fi

#Checking if necessary software is installed
if pacman -Qi tesseract > /dev/null; then
    echo "tesseract is installed, continuing"
else
    sudo pacman -S tesseract
fi

if pacman -Qi tesseract-data-eng > /dev/null; then
    echo "tesseract-data-eng is installed, continuing"
else
    sudo pacman -S tesseract-data-eng
fi

if pacman -Qi ghostscript > /dev/null; then
    echo "ghostscript is installed, continuing"
else
    sudo pacman -S ghostscript
fi
#Convert the pdf to a series of high quality images
convert -verbose -density 300 $1 -quality 100 image-%003d.jpg

for i in ./image-*.jpg; do
    tesseract $i $i pdf
done

#Combine all of the pdf files into one
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=output.pdf image-*.pdf

#Remove all of the files not needed anymore
rm image-*
