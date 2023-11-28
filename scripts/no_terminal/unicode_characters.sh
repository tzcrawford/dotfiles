#!/bin/sh
#use dmenu to select an arbitrary unicode character (e.g. emoji) and copy to clipboard

#REQUIRES XCLIP or wl-clipboard if using wayland.
#Will also want noto-fonts-emoji and ttf-symbola

if [ "$XDG_SESSION_TYPE" = "wayland" ] ; then #if in a wayland session, we need to use wl-clipboard instead of xclip
    grep -v "#" ~/scripts/reference/unicode_characters.txt | ~/scripts/dmenu.sh | awk '{print $1}' | tr -d '\n' | wl-copy
    if [ $(wl-paste) ]; then
        notify-send -u low "$(wl-paste) copied to clipboard."
        exit 0
    else
        notify-send -u low "Nothing copied to clipboard."
        exit 1
    fi
fi



# Give dmenu list of all unicode characters to copy.
grep -v "#" ~/scripts/reference/unicode_characters.txt | ~/scripts/dmenu.sh | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard

# Notifies that the selected character has been copied.
if [ $(xclip -o -selection clipboard) ]; then
    notify-send -u low "$(xclip -o -selection clipboard) copied to clipboard."
    exit 0
else
    notify-send -u low "Nothing copied to clipboard."
    exit 1
fi
