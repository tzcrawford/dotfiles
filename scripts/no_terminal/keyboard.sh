#/bin/sh
#if env | grep "WAYLAND_DISPLAY" > /dev/null ; then
if [ false ] ; then
    if which "xremap" > /dev/null 2>&1 ; then
        # To run this script without sudo, you may need to do something the following (in Arch Linux). See the github page on xremap.
        #   # Ensure uinput is running with `lsmod | grep uinput`. If not,
        #   echo "uinput" > /etc/modules-load.d/uinput
        #   # Possibly you may also need to add modconf to /etc/initramfs.conf or something like that.
        #   echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
        #   and reboot
        echo "
    modmap:
      - name: Swap Super and Alt
        remap:
          ALT_L: SUPER_L
          SUPER_L: ALT_L
    " > $XDG_CONFIG_HOME/xremap/xremap.cfg
        xremap $XDG_CONFIG_HOME/xremap/xremap.cfg & disown
    else
        echo "Could not find xremap , trying to install..." >&2
        #yay -S xremap-wlroots-bin # Install xremap for sway
        if which yay > /dev/null 2>&1 ; then
            yay -S xremap-hypr-bin # Install xremap for hyprland
        else
            echo "Error during install." >&2
            exit 1
        fi
    fi
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
            yay -S xremap-x11-bin # Install xremap for X11
        else
            echo "Error during install." >&2
            exit 1
        fi
    fi
fi


# Make sure numlock is enabled.
if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ] ; then
    hyprctl keyword input:kb_options "numlock:on"
fi

