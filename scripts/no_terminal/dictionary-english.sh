#!/bin/sh
#Pulls up a dmenu list with every word in the english dictionary, selecting brings up a terminal window which shows the dictionary results for that word (written in english)

#I think requires dictd with as well as a source at /usr/share/dict (on Arch Linux, provided with the package "words")
#Do not install packages from AUR like "dict-freedict-deu-eng". It appears to remove dictionary results from `dict -I`. I do not understand what is going on; dictd will not start unless such a dictionary is installed, but you do not need it to be running to do a `dict -d <dictionary> "<word>"` search.

temp=$(cat /usr/share/dict/american-english | dmenu -i -l 15 -fn EnvyCodeR-20 -nb '#2c2c2e' -nf '#c41f52' -sb '#040404' -sf '#f22162')
if ! [ "$temp" = "" ]; then 
    urxvt -e sh -c "dict -d english \"$temp\" | less ; exit" 
fi
