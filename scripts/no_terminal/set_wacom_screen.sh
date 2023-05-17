#!/bin/sh 
# Sets wacom tablet device to use a screen you select from dmenu

DEVNUM="$(xsetwacom --list devices | grep "stylus"  | sed 's/^.*id: //' | awk '{ print $1}')"
MONITORNAME="$(xrandr --listmonitors | awk -F " " '{ if (NR!=1) {print $4 }}' | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')"
if not xsetwacom set $DEVNUM MapToOutput $MONITORNAME ; then
    echo "Failed to map device to screen" >&2
    exit 1
fi

ROTATIONANGLE="$(echo -e "None\n180\nClockwise\nCounterclockwise" | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')"
case "$ROTATIONANGLE" in 
"None")
    xsetwacom set $DEVNUM Rotate none ;;
"180")
    xsetwacom set $DEVNUM Rotate half ;;
"Clockwise")
    xsetwacom set $DEVNUM Rotate cw   ;;
"Counterclockwise")
    xsetwacom set $DEVNUM Rotate ccw  ;;
*)
    echo "Invalid input for rotation angle" >&2
    exit 1
esac

