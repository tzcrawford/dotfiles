#!/bin/bash
# Will split an audio or video
# usage:
#   video-splitter.sh input.mp4 output.mp4 "00:00:00" "00:03:24"

# $1 is the input file
# $2 is the output file
#-vcodec copy sets the videocodec to copy
#-acodec copy sets the audiocodec to copy
#-ss sets the position, i.e. 00:00:00
#-to sets the duration
# so use something like "00:00:00" for each $3 and $4

ffmpeg -i "$1" -vcodec copy -acodec copy -ss "$3" -to "$4" "$2"
