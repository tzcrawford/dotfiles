#!/bin/sh
#an i3 script I wrote to set the background and the colorscheme

#temp=$(echo -e "Rotating Wallpaper\nGrayscale\nSelect" | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#ff944d' -sb '#040404' -sf '#ff6600')
temp=$(echo -e "Rotating Wallpaper\nGrayscale\nSelect" | dmenu -i -l 15 -fn Monospace-18 -nb '#2c2c2e' -nf '#c6cc5e' -sb '#040404' -sf '#eaf51e')
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
