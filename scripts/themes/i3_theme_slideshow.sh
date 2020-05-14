#!/usr/bin/bash
randomfunction(){
    ls ~/Pictures/wallpaper_active | sort -R | tail -1 | while read file
    do echo $file
    done
}
file2=$(randomfunction)
#DISPLAY=:0.0 feh -B white --bg-fill ~/Pictures/wallpaper_active/$file2
wal -i ~/Pictures/wallpaper_active/$file2
crontab ~/scripts/dotfiles/crontab_user
