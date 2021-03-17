#!/bin/sh
# Pipe text in here to copy a user-selected line from that text to your clipboard.
# This looks prettier than regular dmenu

# The awk command removes any trailing new lines

dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600' | awk 1 ORS='' | xclip -selection clipboard
