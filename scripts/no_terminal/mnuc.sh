#!/bin/bash
# For album art backgrounds in ncmpccpp running in urxvt. Does not work in alacritty.

# Requires the ability to printf images to terminal. 
# Dependency rxvt-unicode-pixbuf
# https://aur.archlinux.org/packages/rxvt-unicode-pixbuf/

MUSIC_DIR=$HOME/Music/

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
    if [[ -n "$COVER" ]] ; then
        #resize the image's width to 600px 
        #magick convert "$src" -resize 600x "$COVER"
        magick convert "$src" "$COVER"
        if [[ -f "$COVER" ]] ; then
           #scale down the cover to 50% of the original
           #place it 50% away from left and 85% away from top.
           #printf "\e]20;${COVER};50x50+50+85:op=keep-aspect\a"
           #IDK but suddenly printf will not anymore print the new version if the file it previously printed has changed! So I'm changing it to just point to the source file
           printf "\e]20;${src};50x50+50+85:op=keep-aspect\a" 
           :
        else
            reset_background
        fi
    else
        reset_background
    fi
} &
