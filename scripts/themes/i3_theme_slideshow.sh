#!/usr/bin/bash
#randomly picks an image in ~/Pictures/wallpaper_active/ and sets it as the i3 wallpaper and automatically generates colorscheme palette from image

randomfunction(){
    ls $HOME/Pictures/wallpaper_active | sort -R | tail -1 | while read file
    do echo $file
    done
}
file2=$(randomfunction)
echo $file2
file3="$HOME/Pictures/wallpaper_active/$file2"
echo $file3
#DISPLAY=:0.0 feh -B white --bg-fill $HOME/Pictures/wallpaper_active/$file2
if env | grep "WAYLAND_DISPLAY" > /dev/null ; then
    hyprctl hyprpaper reload ,"$file3"
fi
wal -i "$file3"
#crontab $HOME/scripts/dotfiles/crontab_user

