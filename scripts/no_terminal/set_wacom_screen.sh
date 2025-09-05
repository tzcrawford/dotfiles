#!/bin/sh 
# Sets wacom tablet device to use a screen you select from dmenu

if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] ; then
    DEVICENAME="$(hyprctl devices | awk '
    /^.*Tablet at/ {id=$3}
    /^\t\t[^\t]/   {name=$1}
    /^\t\t\tsize:/ {size=$2; print id " " name " (" size ")"}' | ~/scripts/dmenu.sh -p "Select tablet:" | awk '{print $1}' | sed 's/://g' )"
    echo $DEVICENAME
    #See https://wiki.hypr.land/Configuring/Variables/#tablet
    MONITORNAME="$(hyprctl monitors all | grep "^Monitor " | sed 's/Monitor //g' | sed -E 's/ \(ID [0-9]+\)\://g' | ~/scripts/dmenu.sh -p "Select Screen")"
    hyprctl -r -- keyword input:tablet[$DEVICENAME]:output "$MONITORNAME"
    
    ### This doesn't work???
    #TRANSFORM="$(echo "
    #0 -> normal (no transforms)
    #1 -> 90 degrees
    #2 -> 180 degrees
    #3 -> 270 degrees
    #4 -> flipped
    #5 -> flipped + 90 degrees
    #6 -> flipped + 180 degrees
    #7 -> flipped + 270 degrees
    #" | grep -v "^$" | ~/scripts/dmenu.sh | awk '{print $1}' )"
    #echo $TRANSFORM
    #hyprctl -r -- keyword input:tablet[$DEVICENAME]:transform $TRANSFORM
    
    LEFTHAND="$(echo -e "false\ntrue" | ~/scripts/dmenu.sh -p "Left handed?")"
    echo $LEFTHAND
    hyprctl -r -- keyword input:tablet[$DEVICENAME]:left_handed $LEFTHAND

else


    DEVNUM="$(xsetwacom --list devices | grep "stylus"  | sed 's/^.*id: //' | awk '{ print $1}')"
    MONITORNAME="$(xrandr --listmonitors | awk -F " " '{ if (NR!=1) {print $4 }}' | ~/scripts/dmenu.sh )"
    if not xsetwacom set $DEVNUM MapToOutput $MONITORNAME ; then
        echo "Failed to map device to screen" >&2
        exit 1
    fi
    
    ROTATIONANGLE="$(echo -e "None\n180\nClockwise\nCounterclockwise" | ~/scripts/dmenu.sh )"
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
fi
