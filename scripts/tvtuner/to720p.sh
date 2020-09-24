#!/bin/bash
#$1=input file
#$2=output file
#$3=start time e.g. "01:13:24.163" for one hour 13 min 24.163 s
#$4=end time ^^

#audio bitrate 
    #aac 192kb/s seems standard for stereo
    #ac3 for 5.1 surround seems best at 384k or 448k
    #with hauppauge tuner, don't exceed 384k?
#video bitrate probably 64k minimum, higher is better. 
    #Using 1.5Mb/s for 720p seems okay
    #don't exceed video bitrate 8629k at 1080p
    #using codec h264 for video 
#using scale 720p
#generally, filesize=bitrate*video length in seconds
#using ac3 for audio because card seems to be recording in ac 5.1 384k. Or we can just copy

ffmpeg -i $1 -c:v libx264 -c:a copy -b:v 1500k -s 1280x720 -ss $3 -to $4 $2 
echo "$(du -sh $1) --> $(du -sh $2)"
