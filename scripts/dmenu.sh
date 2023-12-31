#!/bin/bash
# Pipe text in here to return a user-selected line from that text.
# This looks prettier than regular dmenu

FONTFAMILY="monospace"
if xrandr | grep "*" | grep "3840" >/dev/null ; then # Screen is 4k
    FONTSIZE=32 
    NUMLINES=15
else 
    FONTSIZE=20 
    NUMLINES=15
fi

# Set default values
COLORS=('#2c2c2e' '#ffffff' '#040404' '#bbbbbb') # White
PROMPT=""

while getopts 'ogbvryp:' OPTION ; do # Process option provided flags
    case "$OPTION" in
        o) # Sets color
            COLORS=('#2c2c2e' '#ff944d' '#040404' '#ff6600') # Orange
            ;;
        g) # Sets color
            COLORS=('#2c2c2e' '#73ba7f' '#040404' '#24e344') # Green
            ;;
        b) # Sets color
            COLORS=('#2c2c2e' '#00aacc' '#040404' '#00d0ff') # Blue
            ;;
        v) # Sets color
            COLORS=('#2c2c2e' '#c279c4' '#040404' '#f700ff') # Purple
            ;;
        r) # Sets color
            COLORS=('#2c2c2e' '#ff2222' '#040404' '#ff0000') # Purple
            ;;
        y) # Sets color
            COLORS=('#2c2c2e' '#ff944d' '#040404' '#ff6600') # Yellow
            ;;
        p) # Gives prompt
            PROMPT=$OPTARG
            ;;
        ?)
            COLORS=('#2c2c2e' '#ffffff' '#040404' '#bbbbbb') # White
            ;;
    esac
done
shift "$(($OPTIND -1))" # Reset the options flag index

dmenu -i -p "$PROMPT" -l $NUMLINES -fn $FONTFAMILY-$FONTSIZE -nb ${COLORS[0]} -nf ${COLORS[1]} -sb ${COLORS[2]} -sf ${COLORS[3]}

