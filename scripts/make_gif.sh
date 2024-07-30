#!/bin/sh

#I'm too lazy to remember how to make a gif with imagemagick
#the -delay flag sets the framerate. Supposedly -delay N --> 100/N = FPS, but idk
#-loop 0  just means infinite repeat

magick -delay 0.01 -loop 0 *.jpg output.gif
