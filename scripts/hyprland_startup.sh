#!/bin/sh
hyprctl dispatch workspace 11 && pavucontrol & disown
sleep 2
hyprctl dispatch workspace 11 && alacritty -e bluetoothctl & disown
sleep 2
hyprctl dispatch workspace 12 && alacritty -e ~/scripts/in_terminal/email.sh & disown
sleep 2
#hyprctl dispatch workspace 10 && ~/scripts/no_terminal/musicplayer.sh & disown #urxvt doesn't theme correctly 
hyprctl dispatch workspace 1 && qutebrowser & disown
sleep 3
hyprctl dispatch workspace 9 && discord & disown
sleep 5
hyprctl dispatch workspace 1 & disown

