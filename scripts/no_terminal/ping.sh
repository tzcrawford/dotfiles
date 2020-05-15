#!/bin/sh
#gives a notification if you have internet connection and what the ping is
notify-send "ping to 8.8.8.8 $(ping -c 1 8.8.8.8 | sed -n 2p | awk '{ print $7 }')s"
