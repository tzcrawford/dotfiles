#!/bin/sh
#gets process ID for linux executables, uses dmenu for user selection

ps ax | ~/scripts/dmenu.sh | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
if [ $(xclip -o -selection clipboard) ]; then
    notify-send -u low "PID $(xclip -o -selection clipboard) copied to clipboard"
else
    notify-send -u low "Nothing copied to clipboard"
fi
