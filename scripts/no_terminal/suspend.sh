#!/bin/sh
# Tells the computer to temporarily sleep

if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] ; then
    swaylock && sleep 2 && systemctl suspend
else
    i3lock && sleep 2 && systemctl suspend
fi
