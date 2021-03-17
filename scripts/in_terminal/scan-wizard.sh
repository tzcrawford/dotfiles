#!/bin/sh
# Wizard to scan pdfs with

Yes_No ()
{
  echo -n " [Y/n] "
  read YnAnswer
  # all to lower case
  YnAnswer=$(echo $YnAnswer | awk '{print tolower($0)}')
  case $YnAnswer in
    "yes"|"y"|"")  return 0;;
    "no"|"n")  return 1;;
    *)      echo "Please answer yes or no" ; Yes_No ;;
  esac
}

Scan()
{
    file_num=$(printf "%05d" $scan_num) #convert scan_num to a 5 digit string, i.e. 00005
   
    if $OCR_True ; then
        #We tesseract to generate pdf file with searchable text
        #tesseract must take image input
        scanimage --format=png $scan_dimensions | tesseract --dpi $DPI - - pdf > scan-$file_num.pdf || exit 1
    else
        #We just use imagemagick to generate pdf file from scan.
        #png does not support pixels per inch, so I convert to pdf before, theoretically, shrinking to lower DPI
        #If you enter DPI higher than what printer is capable of, you're going to end up with a file larger than it needs to be.
        #I think it experiences unnecessary anti-aliasing?
        scanimage --format=png $scan_dimensions | convert - pdf:- | convert -units PixelsPerInch -density $DPI - pdf:- > scan-$file_num.pdf || exit 1
    fi

    ((scan_num++)) #increment page number by 1
}



echo "Welcome to the scan wizard"
echo "Be aware this wizard may overwrite files matching scan-*.pdf in this directory"

echo -n "Are we scanning on letter paper?"
if Yes_No ; then
    scan_dimensions="-x 215.9 -y 279.4" #this is the string we pass into scanimage
    #we use 215.9 for x and 279.4 for y because this is the dimensions of letter paper in mm
elif echo -n "Should we automatically determine page dimensions?" ; Yes_No ; then
    scan_dimensions=""
    #we pass no -x or -y parameter into scanimage for it to automatically determine dimensions
else
    echo -n "Please enter x dimensions (in mm): "
    read x_dim
    echo -n "Please enter y dimensions (in mm): "
    read y_dim
    scan_dimensions="-x $x_dim -y $y_dim"
fi

echo -n "Should we try to make pages searchable?"
if Yes_No ; then
    OCR_True="true"
else
    OCR_True="false"
fi

echo -n "What DPI do you want your scans to have? (Just press enter to default to 200):  "
read DPI
if [[ $DPI == "" ]] ; then DPI=200 ; fi

#we start with the first scan, page 1
scan_num=0

echo -n "Is your first page scan ready? "
if Yes_No ; then
    Scan
else
    exit 1
fi

continue_scanning=true
while $continue_scanning ; do
    if echo -n "Should we scan another page? Make sure next page is ready before continuing." ; Yes_No ; then
        Scan
    else
        continue_scanning=false
    fi
done

if [ $scan_num == "1" ] ; then #we only scanned one page
    mv scan-00000.pdf scan-output.pdf
    exit 0 #exit success
else
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=scan-output.pdf scan-[0-9]*.pdf #combine all scan files
    if echo -n "Would you like to save individual scan files?" ; Yes_No ; then
        exit 0 #exit success
    else
        rm scan-[0-9]*.pdf
        exit 0 #exit success
    fi
fi
