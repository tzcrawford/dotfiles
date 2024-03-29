#!/bin/sh
# Use dmenu to select a linux process and kill -9 it

SELECTION=$(ps ax | sed '1d' | ~/scripts/dmenu.sh -r -p "Select PID" )

# `ps ax` gives list of all processes
# `sed` command removes header line
#dmenu for user selection
PID=$(echo $SELECTION | awk '{print $1}' | tr -d '\n')
PROCESSNAME=$(echo $SELECTION | cut -d " " -f1,2,3,4 --complement | tr -d '\n')

# `tr` command removes newline character
# `awk` takes column 1
# `cut` removes the first 4 columns
CONFIRMATION=$(echo -e "yes\nno" | ~/scripts/dmenu.sh -r -p "Are you sure you want to kill $PROCESSNAME?" | awk '{print $1}' | tr -d '\n')
if [ $CONFIRMATION = "yes" ]; then
    if $( kill -9 $PID );then
        notify-send -u low "PID $PID killed"
    else
        notify-send "PID $PID kill failed!"
    fi
else
    notify-send -u low "No action taken on PID $PID"
fi

