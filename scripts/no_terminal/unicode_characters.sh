#!/bin/sh
#use dmenu to select an arbitrary unicode character (e.g. emoji) and copy to clipboard

#REQUIRES XCLIP. IF NOT INSTALLED, RUN:
#sudo pacman -S xclip
#Will also want noto-fonts-emoji and ttf-symbola(AUR)

# Give dmenu list of all unicode characters to copy.
grep -v "#" ~/scripts/reference/unicode_characters.txt | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#db2929' -sb '#040404' -sf '#ff0000' | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard

# Notifies that the selected character has been copied.
if [ $(xclip -o -selection clipboard) ]; then
    notify-send -u low "$(xclip -o -selection clipboard) copied to clipboard."
else
    notify-send -u low "Nothing copied to clipboard."
fi
