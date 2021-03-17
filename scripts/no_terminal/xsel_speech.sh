#/bin/sh
#sends x-org selection to spd-say (speech-dispatch)

#sudo pacman -S speech-dispatcher espeak-ng
#make sure you have a proper speechd.conf, or run spd-conf
xsel -o | spd-say -e -w
