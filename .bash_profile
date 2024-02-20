#
# ~/.bash_profile
#


# Default programs
export EDITOR="vim"
#export BROWSER="firefox"
export BROWSER="qutebrowser"
#export TERM="alacritty" # We don't want to do this because linux should determine this automatically.


# Fixing config files to comply with xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"


# Key bindings
if pacman -Q | grep xbindkeys > /dev/null 2>&1;then
    xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config
fi


# Various application env vars
export PARALLEL_HOME="$XDG_DATA_HOME"/parallel
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export MATHEMATICA_USERBASE="$XDG_DATA_HOME"/Mathematica
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
alias wget="wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"
export WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc


### Any Host specific settings ###

if [ $HOSTNAME = fermi ]; then
        ETHINTERFACE='enp1s0f1'
        WLANINTERFACE='wlp2s0'
fi

# Env var for cpu temp info
export cputemppath=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep k10 | grep -v Tdie | sed 's/k10temp: //g' | sed 's/Tctl //g')

# Env var to pull GPU temp info on this machine
if [ $HOSTNAME = dirac ]; then
    export gputemppath=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep "amdgpu: edge" | sed 's/amdgpu: edge //g')

    # For torch etc on ROCM
    export HSA_OVERRIDE_GFX_VERSION=10.3.0
    export HCC_AMDGPU_TARGET=gfx1030
    export PATH=/opt/rocm/bin:$PATH
fi

### Any user specific settings ###

if [ $USER = paul ]; then
        :
fi


 ### Load in .bashrc ###
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# Perlbrew settings
#if (ls $HOME/perl5 | grep perlbrew) > /dev/null 2>&1;then #if perlbrew is installed
#    source $HOME/perl5/perlbrew/etc/bashrc #sources perlbrew settings
#fi


### Start desktop environment/window manager on appropriate tty ###
if [ "$(tty)" = "/dev/tty1" ]; then
    # Remember to put background programs in the line before executing the window manager.
    echo -e "dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY\ndunst &\nnumlockx &\nexec /usr/bin/i3" > ~/.xinitrc
    startx
elif [ "$(tty)" = "/dev/tty2" ]; then
    #if [ "$USER" = "paul" ] ; then echo "exec cinnamon-session" > ~/.xinitrc ; startx ; fi
    #echo "dunst &\nnumlockx &\nexec /usr/bin/bspwm" > ~/.xinitrc #bspwm
    #echo -e "dunst &\nnumlockx &\nwhile true; do exec /usr/bin/dwm 2> /dev/null;done" > ~/.xinitrc #dwm
    #startx
    numlockx & 
    sway
    :
elif [ "$(tty)" = "/dev/tty5" ]; then
    #if [ "$USER" = "paul" ] ; then Hyprland ; fi
    :
else
    :
fi

