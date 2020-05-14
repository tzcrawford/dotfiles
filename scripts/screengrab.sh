#!/bin/sh
#Will record whole screen with default alsa input audio (mic)

ffmpeg -y \
-f x11grab \
-s $(xdpyinfo | grep dimensions | awk '{print $2}') \
-i :0.0 \
-f alsa -i default \
-c:v libx264 -r 30 -c:a libmp3lame $1
