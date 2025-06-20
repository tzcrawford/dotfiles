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
RUNMODE=false

for arg in "$@"; do
    if [[ "$arg" == "--run" ]]; then
        RUNMODE=true
        # Remove this argument from the list
        set -- "${@[@]/$arg}"
    fi
done

while getopts 'ogbvryp:' OPTION ; do # Process option provided flags
    case "$OPTION" in
        o) # Sets color
            COLORS=('#2c2c2e' '#ff944d' '#040404' '#ff6600' '#272729') # Orange
            ;;
        g) # Sets color
            COLORS=('#2c2c2e' '#73ba7f' '#040404' '#24e344' '#272729') # Green
            ;;
        b) # Sets color
            COLORS=('#2c2c2e' '#00aacc' '#040404' '#00d0ff' '#272729') # Blue
            ;;
        v) # Sets color
            COLORS=('#2c2c2e' '#c279c4' '#040404' '#f700ff' '#272729') # Purple
            ;;
        r) # Sets color
            COLORS=('#2c2c2e' '#ff2222' '#040404' '#ff0000' '#272729') # Red
            ;;
        y) # Sets color
            COLORS=('#2c2c2e' '#ff944d' '#040404' '#ff6600' '#272729') # Yellow
            ;;
        p) # Gives prompt
            PROMPT=$OPTARG
            ;;
        ?)
            COLORS=('#2c2c2e' '#ffffff' '#040404' '#bbbbbb' '#272729') # White
            ;;
    esac
done
shift "$(($OPTIND -1))" # Reset the options flag index

if env | grep "WAYLAND_DISPLAY" > /dev/null ; then
    if $RUNMODE ; then
        bemenu-run -i -p "$PROMPT" -l "$NUMLINES" \
            --fn "$FONTFAMILY ${FONTSIZE}" \
            --tb "${COLORS[0]}" --tf "${COLORS[1]}" \
            --nb "${COLORS[0]}" --nf "${COLORS[1]}" \
            --ab "${COLORS[4]}" --af "${COLORS[1]}" \
            --fb "${COLORS[0]}" --ff "${COLORS[1]}" \
            --sb "${COLORS[2]}" --sf "${COLORS[3]}" \
            --cb "${COLORS[1]}" --cf "${COLORS[0]}" \
            --hb "${COLORS[2]}" --hf "${COLORS[3]}"
    else
        bemenu -i -p "$PROMPT" -l "$NUMLINES" \
            --fn "$FONTFAMILY ${FONTSIZE}" \
            --tb "${COLORS[0]}" --tf "${COLORS[1]}" \
            --nb "${COLORS[0]}" --nf "${COLORS[1]}" \
            --ab "${COLORS[4]}" --af "${COLORS[1]}" \
            --fb "${COLORS[0]}" --ff "${COLORS[1]}" \
            --sb "${COLORS[2]}" --sf "${COLORS[3]}" \
            --cb "${COLORS[1]}" --cf "${COLORS[0]}" \
            --hb "${COLORS[2]}" --hf "${COLORS[3]}"
    fi
else
    if $RUNMODE ; then
        dmenu-run -i -p "$PROMPT" -l $NUMLINES -fn $FONTFAMILY-$FONTSIZE -nb ${COLORS[0]} -nf ${COLORS[1]} -sb ${COLORS[2]} -sf ${COLORS[3]}
    else
        dmenu -i -p "$PROMPT" -l $NUMLINES -fn $FONTFAMILY-$FONTSIZE -nb ${COLORS[0]} -nf ${COLORS[1]} -sb ${COLORS[2]} -sf ${COLORS[3]}
    fi
fi

