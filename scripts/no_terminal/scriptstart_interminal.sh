#!/bin/bash
#will spawn a terminal emulator running a script you select via dmenu
#from scripts in ~/scripts/in_terminal/

#temp=$(ls ~/scripts/in_terminal | rofi -sort -i -dmenu)
#temp=$(ls ~/scripts/in_terminal | dmenu -i -l 15 -fn EnvyCodeR-20 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')
temp=$(ls ~/scripts/in_terminal | dmenu -i -l 15 -fn EnvyCodeR-20 -nb '#2c2c2e' -nf '#c279c4' -sb '#040404' -sf '#f700ff')
#if ! [ "$temp" = "" ]; then urxvt -hold -e ~/scripts/in_terminal/$temp; fi
if ! [ "$temp" = "" ]; then alacritty -e ~/scripts/in_terminal/$temp; fi
unset temp
