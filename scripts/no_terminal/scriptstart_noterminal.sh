#!/bin/bash
#temp=$(ls ~/scripts/no_terminal/ | rofi -dmenu)
#temp=$(ls ~/scripts/no_terminal/ | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')
temp=$(ls ~/scripts/no_terminal/ | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#73ba7f' -sb '#040404' -sf '#24e344')
if ! [ "$temp" = ""]; then ~/scripts/no_terminal/$temp; fi
unset temp
