#!/bin/sh
i3-msg 'workspace 11; exec pavucontrol'
i3-msg 'workspace 11; exec urxvt -hold -e bluetoothctl'
i3-msg 'workspace 12; exec urxvt -hold -e ~/scripts/in_terminal/email.sh'
i3-msg 'workspace 0; exec ~/scripts/no_terminal/musicplayer.sh'
i3-msg 'workspace 1; exec qutebrowser'
sleep 3
i3-msg 'workspace 9; exec discord'
sleep 10
i3-msg 'workspace 1'

#i3-msg 'exec ~/.config/polybar/polybarstart.sh'
i3-msg 'restart' # IDK, polybar just isn't starting on intial startup...
