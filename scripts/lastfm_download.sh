#!/bin/sh

# Downloads album art from last fm, right click on the image for the album and copy image address
# Looks like
# https://lastfm.freetls.fastly.net/i/u/500x500/7ff7b2b3c14542fac28df8e5f61403a9.jpg

LINK="$1" # Pass the link in as parameter 1 to this script 
if [ $LINK -eq "" ] ; then exit 1 ; fi

HIGHER_RES_LINK="$(echo "$LINK" | sed 's/500x500/1200x1200/g')" # Change the 500x500 res to 1200x1200
FILENAME="$(echo "$LINK" | sed 's/.*\///g')" # Get the filename for rename

# Download the file
wget "$HIGHER_RES_LINK"


if ! ls cover.jpg > /dev/null ; then
    mv "$FILENAME" "cover.jpg"
    FILENAME="cover.jpg"
else
    echo "cover.jpg is taken, using original filename"
fi

# Give information on the image
NEW_FILENAME="$(identify "$FILENAME" | awk '{ print $1 }' )"
FORMAT="$(      identify "$FILENAME" | awk '{ print $2 }' )"
RESOLUTION="$(  identify "$FILENAME" | awk '{ print $3 }' )"
echo "Collected $NEW_FILENAME as $FORMAT with resolution $RESOLUTION"

# View the image
sxiv "$FILENAME"

