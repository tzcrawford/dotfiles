#!/bin/sh
# Execute this script on the tex file you want to generate a black-text png for.
# usage:
#   tex2pngBlack.sh input.tex


#Include \pagestyle{empty} after declaring the document to make the calculation go faster for high dpi (this excludes white space)
#You need to have imagemagick, dvips, and texi2dvi
#On my PC, texi2dvi is owned by texinfo, which is included in the arch linux base package
#On my PC, dvips is owned by texlive-bin, which is a dependency of texlive-core in arch linux

#Acknowledgement to Michael Mazack for guidance on aliasing issues http://mazack.org/unix/tex2png.php

FILE=$(echo $1 | sed 's/.\{4\}$//') #Removes the last 4 characters (.tex) so we can generate files with other extensions

texi2dvi "$1" #Generate a dvi (device independent file format) file from the tex 
#This appears to be important, just executing the "latex" utility on the tex file to generate a dvi will produce a lower resolution image in the end.

dvips -E "$FILE.dvi"  #Generate a postscript version of this dvi

magick -density 1200 -colorspace RGB -trim "$FILE.ps" "$FILE.png" #convert to png
#-density declares the resolution of the resulting image. 
#-colorspace RGB stops an error by explicitly declaring the RGB colorspace.
#-channel RGB -negate will swap the black text into white while just -negate will turn black into alpha and alpha into black
#-trim removes any unnecessary alpha space around the text to reduce final size

#cleanup
rm "$FILE.aux" "$FILE.log" "$FILE.dvi" "$FILE.ps"
