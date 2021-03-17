#!/bin/sh
# Generates a pdf file from a markdown text file using pandoc
# Consider changing the font given what is available on your system `fc-list`

# Input file must have .md extension!
# Optionally pass second argument $2 for a template
# usage:
#   markdown-to-pdf-pandoc.sh "file.md" ["template.tex"]

inputfile="$1"
outputfile="$(echo "$inputfile" | sed 's/\.md$/\.pdf/g')" #now we search and replace .md extension with .pdf
templatefile="$2"
if [ -n ${templatefile+x} ] ; then #if a template file was given
    #pandoc -i "$inputfile" -f markdown -t pdf -o "$outputfile" --pdf-engine=xelatex -V mainfont="Liberation Serif" --template="$templatefile"
    pandoc -i "$inputfile" -f markdown -t pdf -o "$outputfile" --pdf-engine=xelatex --template="$templatefile"
else 
    #pandoc -i "$inputfile" -f markdown -t pdf -o "$outputfile" --pdf-engine=xelatex -V mainfont="Liberation Serif"
    pandoc -i "$inputfile" -f markdown -t pdf -o "$outputfile" --pdf-engine=xelatex
fi
#CJKmainfont="NotoSansCJK-Regular" #may need to provide extra font for odd characters
