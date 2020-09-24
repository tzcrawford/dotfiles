#!/bin/sh
#Will record whole screen with default alsa input audio (mic)
#$1 is the output file name
#$2 if exists is the pulse audio card source, else defaults to 4. To determine, run `pactl list sources | less` and search through the "Sources". The script is hard-coded for audio card 1 `-ac 1`

if [ -z "$2" ]
  then
    #echo "No audio source supplied"
    audiosource="4"
else
    audiosource=$2
fi

ffmpeg -y \
-f x11grab \
-s $(xdpyinfo | grep dimensions | awk '{print $2}') \
-i :0.0 \
-f pulse -ac 1 -i $audiosource \
-c:v libx264 -r 30 -preset ultrafast -c:a aac \
$1 

#-c:v libx264 -r 30 -c:a aac $1
#-f alsa -i default \
#-c:v mpeg2video -r 30 -c:a ac3 $1
