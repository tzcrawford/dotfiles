#!/bin/sh
expressvpn disconnect > /dev/null 2>&1
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

while true;
do
    sleep 1
    if [ "$( nmcli device | grep "wlp" | grep -v "p2p" | awk '{ print $3 }' )" == "connected" ]; then
        notify-send "wifi connected"
        echo "wifi connected"
        break
    fi
done 

expressvpn connect > /dev/null 2>&1

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

sleep 1

#notify-send "ping to 8.8.8.8 $(ping -c 1 8.8.8.8 | sed -n 2p | awk '{ print $7 }')ms"
Pingline="$(ping -c 2 8.8.8.8 2>&1)" #run a ping line collecting 2 packets. Collects standard output and err
if echo "$Pingline" | grep -iq "Network is unreachable"; then
    notify-send "network error, ping could not be established"
    echo "network error, ping could not be established" >&2
    exit 1 #exit with error
else
    Pingline="$(echo "$Pingline" | grep "bytes from")" #only take the lines which give the actual time of ping
    Pingline="$(echo "$Pingline" | sed -n '2p')" #only take the 2nd packet (the first might be a bit longer for some reason)
    Pingline="$(echo "$Pingline" | awk '{ print $7 }')" #only take column 7 "time=whatever"
    Pingline="$(echo "$Pingline" | sed 's/time=//g')" #remove "time=" so we just have the ping time
    Pingline="$(echo "$Pingline" | sed 's/\.[0-9]//g')" #remove after decimal point
    Pingline="ping to 8.8.8.8: ${Pingline} ms"
    notify-send "$Pingline"
    echo "$Pingline"
fi
