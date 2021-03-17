#!/bin/sh
# Get a list of available channels, select one from dmenu, and play it on a chosen tuner

#get the channel name with dmenu
locChannelConfig=~/.config/azap/channels.conf
channel="$(cat $locChannelConfig | sed 's/:.*//g' | dmenu -i -p "Which channel would you like to play?" -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')" 
tunerNum="$(echo -e "0\n1" | dmenu -i -p "Which tuner should be used?" -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')" 
( azap -r -a $tunerNum -c "$locChannelConfig" "$channel" )&
ps1=$! 
#disown a process which will play the video and disable the tuner when done
mpv /dev/dvb/adapter$tunerNum/dvr0 ; kill $ps1 & disown
