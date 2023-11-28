#!/usr/bin/bash
#sets i3 to use a black background and you use dmenu to select a colorscheme (for terminals etc)
DISPLAY=:0.0 feh -B white --bg-fill ~/scripts/themes/black.png
#wal -f base16-grayscale
wal -f "$(~/scripts/dmenu.sh < ~/scripts/themes/themes)"
#head -n -1 ~/scripts/dotfiles/crontab_user > ~/tempfile
#crontab ~/tempfile
#rm ~/tempfile
