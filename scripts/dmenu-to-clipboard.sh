#!/bin/sh
# Pipe text in here to copy a user-selected line from that text to your clipboard.
# This looks prettier than regular dmenu

# The awk command removes any trailing new lines

~/scripts/dmenu.sh | awk 1 ORS='' | xclip -selection clipboard
