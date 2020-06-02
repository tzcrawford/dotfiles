#!/bin/sh
#pipe a list of newline separated item to this script and you can have dmenu send your selection to clipboard
#the awk command removes any trailing new lines
dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600' | awk 1 ORS='' | xclip -selection clipboard
