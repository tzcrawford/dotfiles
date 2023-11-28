#!/bin/bash
#will run a script you select via dmenu
#from scripts in ~/scripts/no_terminal/

temp=$(ls ~/scripts/no_terminal/ | ~/scripts/dmenu.sh -g )
if ! [ "$temp" = "" ]; then ~/scripts/no_terminal/$temp; fi
unset temp
