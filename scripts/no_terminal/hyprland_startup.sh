#!/bin/sh
hyprctl dispatch 'hl.dsp.focus({ workspace = "11" })' && pavucontrol & disown
sleep 2
hyprctl dispatch 'hl.dsp.focus({ workspace = "11" })' && alacritty -e bluetoothctl & disown
sleep 2

if [ "$HOSTNAME" = "dirac" ] || [ "$HOSTNAME" = "curie" ]; then
    hyprctl dispatch 'hl.dsp.focus({ workspace = "12" })' && alacritty -e ~/scripts/in_terminal/email.sh & disown
    sleep 2
    
    hyprctl dispatch 'hl.dsp.focus({ workspace = "10" })' && ~/scripts/no_terminal/musicplayer.sh & disown
    sleep 2
fi

hyprctl dispatch 'hl.dsp.focus({ workspace = "1" })' && qutebrowser & disown
sleep 3

if [ "$HOSTNAME" = "dirac" ] ; then
    hyprctl dispatch 'hl.dsp.focus({ workspace = "9" })' && discord & disown
    sleep 5
fi

hyprctl dispatch 'hl.dsp.focus({ workspace = "1" })'

