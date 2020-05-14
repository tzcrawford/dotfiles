#!/bin/sh
expressvpn disconnect
notify-send "$(expressvpn status | head -n 1 | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g')" #the sed part removes ANSI color codes from the text stream

while true;
do
    sleep 1
    if [ "$( nmcli device | grep "wlp" | grep -v "p2p" | awk '{ print $3 }' )" == "connected" ]; then
        notify-send "wifi connected"
        break
    fi
done 

expressvpn connect
notify-send "$(expressvpn status | head -n 1 | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g')" #the sed part removes ANSI color codes from the text stream
sleep 1
notify-send "ping to 8.8.8.8 $(ping -c 1 8.8.8.8 | sed -n 2p | awk '{ print $7 }')s"
