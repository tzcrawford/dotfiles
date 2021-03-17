#!/bin/bash
# Converts a video file to a gif

#$1=input file
#$2=output file
#$3=framerate
#$4=scale, e.g. 480:270
#$5=aspect ratio, e.g. 16:9

ffmpeg -i "$1" -vf scale="$4",setdar="$5" -r "$3" "$2" -hide_banner
echo "$(du -sh "$1") --> $(du -sh "$2")"
