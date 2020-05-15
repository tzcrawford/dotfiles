#!/bin/sh
#use dmenu to select a linux process and kill -9 it

SELECTION=$(ps ax | sed '1d' | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#d12e75' -sb '#040404' -sf '#ff006f')
#ps ax gives list of all processes
#sed command removes header line
#dmenu for user selection
PID=$(echo $SELECTION | awk '{print $1}' | tr -d '\n')
PROCESSNAME=$(echo $SELECTION | cut -d " " -f1,2,3,4 --complement | tr -d '\n')
#tr command removes newline character
#awk takes column 1
#cut removes the first 4 columns
CONFIRMATION=$(echo -e "yes\nno" | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#d12e75' -sb '#040404' -sf '#ff006f' -p "Are you sure you want to kill $PROCESSNAME?" | awk '{print $1}' | tr -d '\n')
if [ $CONFIRMATION == "yes" ]; then
    if $( kill -9 $PID );then
        notify-send "PID $PID killed"
    else
        notify-send "PID $PID kill failed!"
    fi
else
    notify-send "No action taken on PID $PID"
fi

