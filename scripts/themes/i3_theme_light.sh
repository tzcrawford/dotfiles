#!/usr/bin/bash
DISPLAY=:0.0 feh -B white --bg-fill ~/scripts/themes/white.png
#wal -f base16-grayscale
wal -f "$(rofi -dmenu <  ~/scripts/themes/themes_light)"
head -n -1 ~/scripts/dotfiles/crontab_user > ~/tempfile
crontab ~/tempfile
rm ~/tempfile
