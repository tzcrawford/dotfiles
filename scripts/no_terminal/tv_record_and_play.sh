#!/bin/sh
# record ATSC transport stream
# can do so for periods not divisible by one minute (bc is used instead of sh math)

configfile=~/.config/azap/channels.conf
outputdir=~/Captures

if ! pacman -Q yad >/dev/null || ! pacman -Q dmenu >/dev/null ; then echo "Yad or Dmenu not installed!" ; exit 1; fi #throw error and exit if dependencies not installed

if ! channel="$(cat $configfile | sed 's/:.*//g' | dmenu -i -p "Which channel would you like to play?" -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')" ; then
    yad --on-top --fixed --borders=20 --text "Exiting, no channel selected."
    exit 1
fi

#if channel is not in config file, exit and throw error
if ! cat $configfile | grep -q "$channel"; then yad --on-top --fixed --borders=20 --text "channel name not found"; exit 1; fi

#get name of recording
name="$( yad --on-top --fixed --borders=20 --title "TV Record and Play" --text "What should the capture be named?" --entry )"

#get tuner number
tunerNum="$(echo -e "0\n1" | dmenu -i -p "Which tuner should be used?" -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')" 
#if adapter is not declared, default is 0
if [ -z $tunerNum ]; then
    set "0"
fi

PREFIX=`date +%F-%H-%M` # part of filename
FNAME=$outputdir/${PREFIX}_$name.mpeg

echo -e "recording $FNAME \non channel $channel with adapter $tunerNum" & disown

#make ~/Captures if it doesn't exist; else do nothing
if [ ! -d $outputdir ]; then mkdir -p $outputdir >/dev/null 2>&1; else : ; fi 
   
echo "Selecting the DVB-T channel"
#( azap -r -a $tunerNum -c $configfile "$channel" )&
( azap -r -a $tunerNum -c $configfile "$channel" > /dev/null 2>&1 )&
ps1=$! #Process ID for tuning to channel
( cat /dev/dvb/adapter$tunerNum/dvr0 > ${FNAME} )&
ps2=$! #Process ID for recording
#mpv $FNAME ; kill $ps1 $ps2 & disown
sleep 10 ; mpv $FNAME ; kill $ps1 $ps2 & disown
