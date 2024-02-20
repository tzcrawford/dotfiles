if which "xremap" > /dev/null 2>&1 ; then
    xremap $XDG_CONFIG_HOME/xremap/xremap.cfg & disown
else
    if which "xmodmap" > /dev/null 2>&1 ; then
        xmodmap -e "clear mod1"
        xmodmap -e "clear mod4"
        xmodmap -e "keycode 133 = Alt_L"
        xmodmap -e "keycode 64 = Super_L"
        xmodmap -e "keycode 108 = Super_R"
        xmodmap -e "add mod1 = Alt_L Alt_R"
        xmodmap -e "add mod4 = Super_L Super_R"
    else
        echo "Could not find xremap or xmodmap, trying to install..." >&2
        if which yay > /dev/null 2>&1 ; then
            if which sway > /dev/null 2>&1 ; then
                yay -S xremap-wlroots-bin # Install xremap for sway
            else
                yay -S xremap-x11-bin # Install xremap for X11
            fi
        else
            echo "Aborting..." >&2
        fi
    fi
fi


