#!/bin/bash
# record ATSC transport stream
# can do so for periods not divisible by one minute (bc is used instead of bash math)

#Argument 1 ($1) is the name of what you are recording (don't use spaces etc.)
#Argument 2 ($2) is the channel name (use quotations e.g. "KGCL 15")
#Argument 3 ($3) is time to record in minutes
#Argument 4 ($4) is adapter number (0 or 1 on a Hauppauge WinTV-DualHD, may have more or less depending on device)

configfile=~/.config/azap/channels.conf
outputdir=~/Captures

#if time is not a valid number, throw error
seconds="$(echo "$3*60" | bc | sed 's/\..*//g')" #need to use bc calculator in case $3 is a decimal. sed command deletes everything after the decimal
re='^[0-9]+$' #regular expression for number
if ! [[ $seconds =~ $re ]]; then
    echo "time to record is not a valid number"
    exit 1 #exit script with an failure status (i.e. false)
fi

#if channel is not in config file, exit and throw error
if ! cat $configfile | grep -q "$2"; then echo "channel name not found"; exit 1; fi

#if adapter is not declared, default is 0
if [ -z $4 ]; then
    set "0"
fi

PREFIX=`date +%F-%H-%M` # part of filename
FNAME=$outputdir/${PREFIX}_$1.mpeg

echo -e "recording $FNAME \non channel $2 for $3 minutes with adapter $4"

#make ~/Captures if it doesn't exist; else do nothing
if [ ! -d $outputdir ]; then mkdir -p $outputdir >/dev/null 2>&1; else : ; fi 
   
echo "Selecting the DVB-T channel"
( azap -r -a $4 -c $configfile $2 > /dev/null 2>&1 )&
ps1=$! #Process ID for tuning to channel
#echo "Starting record of ${FNAME}"
#( cat /dev/dvb/adapter$4/dvr0 > ${FNAME} )&
#Not using cat anymore because if kernel doesn't schedule this process frequently enough, you can get a low-level cat error "Value too large for defined data type".
#This is because the /dev/.../dvr0 buffer has overflown
#Same thing can happen with dd with the small default ibs of 512 bytes, thus here we raise it to 1M.
#The ibs option is the maximum number of bytes it can read up to at one time. Larger make overflow less likely
#You don't want it to be too large because if you cancel the process mid-read, it will not save the beginning of that block.
#I am also adding conv=noerror so that it doesn't stop copying in the case of a buffer overflow or error
( dd if=/dev/dvb/adapter$4/dvr0 ibs=1048576 conv=noerror of=${FNAME} )&
ps2=$! #Process ID for recording
echo Waiting $3 minutes before kill of $ps1 and $ps2
sleep $seconds
kill $ps2 $ps1
echo "Recording of $1 finished"
