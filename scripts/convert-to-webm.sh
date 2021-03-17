#!/bin/sh
# Converts video file to one with typical webm codec.
# Experiment some different bitrates to optimize quality/size
# usage:
#   convert-to-webm.sh input.mp4 output.webm 128k 500k 480x270

#$1=input file
#$2=output file
#$3=audio bitrate, 32k minimum. 64-128k recommended
#$4=video bitrate, probably 64k minimum, higher is better
#$5=scale, e.g. 480x270
#generally, filesize=bitrate*video length in seconds

ffmpeg -i "$1" -c:v libvpx -c:a libvorbis -b:a "$3" -b:v "$4" -s "$5" "$2"
echo "$(du -sh "$1") --> $(du -sh "$2")"
