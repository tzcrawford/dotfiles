#!/bin/bash
#Requires the ability to printf images to terminal. Dependency rxvt-unicode-pixbuf
#https://aur.archlinux.org/packages/rxvt-unicode-pixbuf/

case $HOSTNAME in
        dirac)
            MUSIC_DIR=$HOME/ext/Music/
            ;;
        *)
            MUSIC_DIR=$HOME/Music/
esac 

COVER=/tmp/cover.jpg

function reset_background
{
    printf "\e]20;;100x100+1000+1000\a"
}

{
    album="$(mpc --format %album% current)"
    file="$(mpc --format %file% current)"
    album_dir="${file%/*}"
    [[ -z "$album_dir" ]] && exit 1
    album_dir="$MUSIC_DIR/$album_dir"

    covers="$(find "$album_dir" -type d -exec find {} -maxdepth 1 -type f -iregex ".*/.*\(${album}\|cover\|folder\|artwork\|front\).*[.]\(jpe?g\|png\|gif\|bmp\)" \; )"
    src="$(echo -n "$covers" | head -n1)"
    rm -f "$COVER" 
    if [[ -n "$src" ]] ; then
        #resize the image's width to 600px 
        #convert "$src" -resize 600x "$COVER"
        convert "$src" "$COVER"
        if [[ -f "$COVER" ]] ; then
           #scale down the cover to 50% of the original
           #place it 50% away from left and 85% away from top.
           printf "\e]20;${COVER};50x50+50+85:op=keep-aspect\a"
           :
        else
            reset_background
        fi
    else
        reset_background
        #cp ~/scripts/themes/black.jpg $COVER
    fi
} &
