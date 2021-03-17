#!/bin/sh
#Converts a directory of m4a music files to mp3


#Checking if necessary software is installed (on arch linux)
if lsb_release -a | grep "Arch Linux" > /dev/null; then
    for package in ffmpeg lame ; do 
        if ! pacman -Qi $package > /dev/null; then
            echo $package is not installed!
            sudo pacman -S $package
        fi
    done
fi

#Convert the m4as to wav and then mp3
        for i in *.m4a
do
        #mplayer -ao pcm "$i" -aofile "$i.wav"
        #-aofile has been removed. Use -ao pcm:file=<filename> instead
        #mplayer -ao pcm:"$i"=<"$i.wav">
        ffmpeg -i "$i" "$i.wav"
        lame -h -b 320 "$i.wav" "$i.mp3"
done

#Fix the filenames so it is only a .mp3 extension
for i in *.mp3
do
        x=`echo "$i" | sed -e 's/m4a.mp3/mp3/'`
        mv "$i" "$x"
done
