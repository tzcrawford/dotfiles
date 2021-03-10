#!/usr/bin/bash
#sets i3 to use a black background and you use dmenu to select a colorscheme (for terminals etc)
DISPLAY=:0.0 feh -B white --bg-fill ~/scripts/themes/black.png
#wal -f base16-grayscale
#wal -f "$(rofi -dmenu <  ~/scripts/themes/themes)"
#wal -f "$(dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600' < ~/scripts/themes/themes)"
wal -f "$(dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#c6cc5e' -sb '#040404' -sf '#eaf51e' < ~/scripts/themes/themes)"
#head -n -1 ~/scripts/dotfiles/crontab_user > ~/tempfile
#crontab ~/tempfile
#rm ~/tempfile
