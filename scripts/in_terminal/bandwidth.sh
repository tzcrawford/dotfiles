#!/bin/sh
#records how much bandwidth (data) you have used since computer started 
#check if installed
if lsb_release -a | grep "Arch Linux" > /dev/null; then
    if ! pacman -Qi vnstat > /dev/null; then
        sudo pacman -S vnstat
        sudo systemctl enable --now vnstat
    fi
fi
vnstat
