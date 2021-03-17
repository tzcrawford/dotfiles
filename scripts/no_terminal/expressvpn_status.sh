#!/bin/sh
#notify-send "$(expressvpn status | head -n 1 | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g')" #the sed part removes ANSI color codes from the text stream

ExpStat="$(expressvpn status 2>&1)" #get the status of expressvpn
ExpStat="$(echo "$ExpStat" | grep -v "If your VPN connection unexpectedly drops")" #remove this un-needed line
ExpStat="$(echo "$ExpStat" | grep -v "To disable Network Lock")" #remove this un-needed line
ExpStat="$(echo "$ExpStat" | grep -v "[vV]ersion")" #remove any line trying to get you to update or something
ExpStat="$(echo "$ExpStat" | grep -v "Check your internet")" #remove this un-needed line in the case of "Unable to connect"
ExpStat="$(echo "$ExpStat" | grep -v "Internet traffic")" #..
ExpStat="$(echo "$ExpStat" | grep -v "To retry the connection")" #...
ExpStat="$(echo "$ExpStat" | grep -v "To disconnect from")" #...
ExpStat="$(echo "$ExpStat" | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g')" #remove ANSI color codes from the text stream
notify-send "expressvpn status: $ExpStat"
echo "expressvpn status: $ExpStat"
