#!/bin/sh
#gives a notification if you have internet connection and what the ping is

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
    notify-send -u low "$Pingline"
fi

