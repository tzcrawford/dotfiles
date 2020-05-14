#!/bin/sh 
DEVNUM=$(xsetwacom --list devices | grep "stylus"  | sed 's/^.*id: //' | awk '{ print $1}')
MONITORNAME=$(xrandr --listmonitors | awk -F " " '{ if (NR!=1) {print $4 }}' | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')
xsetwacom set $DEVNUM MapToOutput $MONITORNAME
