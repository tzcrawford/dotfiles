#/bin/sh
# Compiles latex documents with biber bibliography

FILE=$(echo "$1" | sed 's/.\{4\}$//') #removes last 4 characters (.tex)
pdflatex "$1" && biber "$FILE" && pdflatex "$1" && pdflatex "$1"
