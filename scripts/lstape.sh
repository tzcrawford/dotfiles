#!/bin/sh
# lists all contents of LTO tape, probably pipe this into a file
# optionally use argument $1 to declare which file represents the tape e.g. /dev/nst1

if [ -z "$1" ]; then #if no argument was given
    tapefile=/dev/nst0
else
    tapefile=$1
fi

#I found out that the drive will not respond to some commands correctly unless you set an option on the drive to allow it to become a logical device. Here is that command, It has to be used every time the PC is booted up before the drive is used. Adding it to a startup file somewhere is likely a good idea...
mt-st -f $tapefile stsetoptions scsi2logical

mt-st -f $tapefile asf 0; #position tape to the first archive

while true;
do
        #current block number
        b=$(mt-st -f $tapefile tell | sed 's/At block //g' | sed 's/\.$//g')

        #current archive number
        a=$(mt-st -f $tapefile status | grep "File number" | sed 's/File number=//g' | sed 's/, block number.*//g' )

        #contents of current archive
	l=$(tar tvf $tapefile 2> /dev/null); #list of all files in the record, disregard STDERR
        
        #if $l is empty, break the loop and exit
	! [[ -z "$l" ]] || break ;

	printf -- "archive $a (block $b) -- \n" #header for this archive
        printf -- "$l\n" #print to terminal that the contents are under this archive
	mt-st -f $tapefile fsf 1 #move the tape forward one record
done
