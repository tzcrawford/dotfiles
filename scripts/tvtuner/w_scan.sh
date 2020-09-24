#!/bin/sh

#Scans for TV channels with an ATSC transmission/tuner
#Argument 1 ($1) is the output config file name
#Argument 2 ($2) is transmission type. 1 for air 2 for cable

#we use w_scan2 but same syntax for w_scan

if lsb_release -a | grep "Arch Linux" > /dev/null; then
if ! pacman -Q | grep w_scan2 ;then
    yay -S w_scan2
fi
fi

w_scan2 -fa -A$2 -c US -X | sed 's/VSB_8/8VSB/g'| tee $1
#-fa for ATSC (North America transmission format)
#-A1 is over the air
#-A2 is QAM annex B (cable TV)
#-A3 is both
#-c US for country US
#-X for a/c/tzap/xine format
#sed command is needed to change VSB_8 to
