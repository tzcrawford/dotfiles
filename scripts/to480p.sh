#!/bin/sh
# Converts video to 720p
# example usage:
#   to480p.sh "input.mp4" "output.mp4" "00:00:00" "01:03:24"

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
    #Using 1.5Mb/s for 480p seems okay
    #don't exceed video bitrate 8629k at 1080p
    #using codec h264 for video 

#using ac3 for audio because card seems to be recording in ac 5.1 384k. Or we can just copy
#ffmpeg -i "$1" -c:v libx264 -c:a aac       -b:a 192k -b:v 1.5M  -s 720x480 -ss "$3" -to "$4" "$2" 
#ffmpeg -i "$1" -c:v libx264 -c:a ac3       -b:a 384k -b:v 1.5M  -s 720x480 -ss "$3" -to "$4" "$2" 

ffmpeg -i "$1" -c:v libx264 -c:a copy                -b:v 1500k -s 720x480 -ss "$3" -to "$4" "$2" 
echo "$(du -sh "$1") --> $(du -sh "$2")"
