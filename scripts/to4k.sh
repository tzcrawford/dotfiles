#!/bin/sh
# Converts video to 4k
# example usage:
#   to4k.sh "input.mp4" "output.mp4" "00:00:00" "01:03:24"

# $1 = input file
# $2 = output file
# $3 = start time (e.g. "01:13:24.163" for one hour 13 min 24.163 s)
# $4 = end time

#generally, filesize=bitrate*video length in seconds
#audio bitrate 
    #32k minimum. 64-128k recommended. 
    #aac 192kb/s seems standard for stereo
    #ac3 for 5.1 surround seems best at 384k or 448k
    #with hauppauge tuner, don't exceed 384k?
#video bitrate probably 64k minimum, higher is better.
    #Using 4Mb/s for 1080p seems okay, 6500 more recommended
    #don't exceed video bitrate 8629k at 1080p
    #using codec h264 for video 

ffmpeg -i "$1" -c:v libx264 -c:a copy -b:v 40M -s 3840x2160 -ss "$3" -to "$4" "$2" 
echo "$(du -sh "$1") --> $(du -sh "$2")"
