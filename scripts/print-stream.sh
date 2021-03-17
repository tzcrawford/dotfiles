#!/bin/sh
# Pipe a text stream into this script, and it will produce a printable pdf of the text

# first argument of the name of the output pdf
# second argument the size of font you want to use
# usage:
#   cat file.txt | print-stream.sh "file.pdf" 12

enscript --pretty-print --color --encoding=88591 --font="Courier$2" -B -o - | ps2pdf - "$1"

#`--pretty-print --color`
#       syntax highlighting
#`--encoding=88591`
#       specifying iso-88591 (latin-1) encoding.
#       special utf-8 characters will not work
#       you can first pass stream through `iconv -f utf-8 -t iso-8859-1` to convert your stream to this encoding if you want
#`--font="Courier$2"`
#       The default font for enscript is courier, with a size directly, e.g. `Courier12`
#       You can't just do any font on your system because enscript keeps its own fonts, idk how that works
#`-B`
#       this disables the default header which declares the input file name etc
#       you would usually do `enscript -o file.ps file.txt` to
#`-o`
#       this specifies that you want to output to a file (or stream) as opposed to send to printer
#`-`
#       stop taking arguments (e.g. input file name)
#ps2pdf - "$1"
#       convert the postscript stream to pdf
#       the `-` specifies to stop taking arguments, i.e. use the piped-in text stream for input
#       `$1` is the first argument output-file name
