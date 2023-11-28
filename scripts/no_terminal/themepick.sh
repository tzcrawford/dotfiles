#!/bin/sh
#an i3 script I wrote to set the background and the colorscheme

temp=$(echo -e "Rotating Wallpaper\nGrayscale\nSelect" | ~/scripts/dmenu.sh )
if [ "$temp" = "Rotating Wallpaper" ]; then
        ~/scripts/themes/i3_theme_slideshow.sh
elif [ "$temp" = "Grayscale" ]; then
        ~/scripts/themes/i3_theme_grayscale.sh
elif [ "$temp" = "Select" ]; then
        ~/scripts/themes/i3_theme_dark.sh
else
        :
fi
unset temp
