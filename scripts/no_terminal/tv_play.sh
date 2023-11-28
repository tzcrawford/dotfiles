#!/bin/sh
# Get a list of available channels, select one from dmenu, and play it on a chosen tuner

#get the channel name with dmenu
locChannelConfig=~/.config/azap/channels.conf
channel="$(cat $locChannelConfig | sed 's/:.*//g' | ~/scripts/dmenu.sh -p "Which channel would you like to play?")" 
tunerNum="$(echo -e "0\n1" | ~/scripts/dmenu.sh -p "Which tuner should be used?"" 
( azap -r -a $tunerNum -c "$locChannelConfig" "$channel" )&
ps1=$! 
#disown a process which will play the video and disable the tuner when done
mpv /dev/dvb/adapter$tunerNum/dvr0 ; kill $ps1 & disown
