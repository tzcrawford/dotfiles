#!/bin/sh
if neofetch | grep -i "WM.*i3" ; then
    wm_msgr=i3-msg
elif neofetch | grep -i "WM.*sway" ; then
    wm_msgr=swaymsg
else
    exit
fi

$wm_msgr 'workspace 11; exec pavucontrol'
sleep 2
$wm_msgr 'workspace 11; exec alacritty -e bluetoothctl'
sleep 2
$wm_msgr 'workspace 12; exec alacritty -e ~/scripts/in_terminal/email.sh'
sleep 2
#$wm_msgr 'workspace 0; exec ~/scripts/no_terminal/musicplayer.sh' #urxvt doesn't theme correctly

$wm_msgr 'workspace 1; exec qutebrowser'
sleep 3
$wm_msgr 'workspace 9; exec discord'
sleep 5
$wm_msgr 'workspace 1'

$wm_msgr 'restart' # IDK, polybar just isn't starting on intial startup...

