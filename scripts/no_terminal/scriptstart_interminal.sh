#!/bin/bash
#will spawn a terminal emulator running a script you select via dmenu
#from scripts in ~/scripts/in_terminal/


temp=$(ls ~/scripts/in_terminal | ~/scripts/dmenu.sh -v )

#if ! [ "$temp" = "" ]; then urxvt -hold -e ~/scripts/in_terminal/$temp; fi
if ! [ "$temp" = "" ]; then 
    if command -v wal > /dev/null 2>&1 ; then
        sleep 0.1 && wal -Rqe & disown # Reload color scheme in the newly spawned window. This is buggy, needs adjustment.
    fi
    alacritty --hold -e ~/scripts/in_terminal/$temp
fi

unset temp
