#!/bin/bash
# Converts flac files in this directory to mp3 files

#for a in ./*.flac; do
#         < /dev/null ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
#done

parallel ffmpeg -i {} -qscale:a 0 {.}.mp3 ::: ./*.flac
