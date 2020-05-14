#!/bin/sh
notify-send "$(expressvpn status | head -n 1 | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g')" #the sed part removes ANSI color codes from the text stream
