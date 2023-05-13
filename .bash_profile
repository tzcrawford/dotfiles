#
# ~/.bash_profile
#

export PANEL_FIFO="/tmp/panel-fifo"

#default programs
export EDITOR="vim"
#export BROWSER="firefox"
export BROWSER="qutebrowser"


#fixing config files to comply with xdg
export XDG_CONFIG_HOME="$HOME/.config" #set xdg config home default
export XDG_DATA_HOME="$HOME/.local/share"
export cputemppath=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep k10 | grep -v Tdie | sed 's/k10temp: //g' | sed 's/Tctl //g')

#export XAUTHORITY="$XDG_CONFIG_HOME"/Xauthority
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
if pacman -Q | grep xbindkeys > /dev/null 2>&1;then
    xbindkeys -f "$XDG_CONFIG_HOME"/xbindkeys/config
fi
export PARALLEL_HOME="$XDG_DATA_HOME"/parallel
export GOPATH="$XDG_DATA_HOME"/go
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export MATHEMATICA_USERBASE="$XDG_DATA_HOME"/Mathematica
#svn --config-dir "$XDG_CONFIG_HOME"/subversion #is not working?
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
alias wget="wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"
#export VIMINIT='source "$XDG_CONFIG_HOME/vim/vimrc"' #not working
export WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc

#Any Host specific settings
if [ $HOSTNAME = landau ]; then
    #Hardware acceleration https://wiki.archlinux.org/index.php/Hardware_video_acceleration#Configuring_VDPAU
    export VDPAU_DRIVER=va_gl
    export LIBVA_DRIVER_NAME=i965

elif [ $HOSTNAME = fermi ]; then
        ETHINTERFACE='enp1s0f1'
        WLANINTERFACE='wlp2s0'

elif [ $HOSTNAME = dirac ]; then
    #export gputemppath=$(find /sys/devices/pci0000:00/0000:00:*/0000:0*:00.0/hwmon/hwmon*/temp1_input)
    export gputemppath=$(for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep "amdgpu: edge" | sed 's/amdgpu: edge //g')

fi

#Any user specific settings
if [ $USER = paul ]; then
        :
fi



#load in .bashrc
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
#
#if (ls $HOME/perl5 | grep perlbrew) > /dev/null 2>&1;then #if perlbrew is installed
#    source $HOME/perl5/perlbrew/etc/bashrc #sources perlbrew settings
#fi
#

#Starts desktop environment/window manager on appropriate tty
if [ "$(tty)" = "/dev/tty2" ]; then
    if [ "$USER" = "paul" ] ; then echo "exec cinnamon-session" > ~/.xinitrc ; startx ; fi 
    #echo "dunst &\nnumlockx &\nexec /usr/bin/bspwm" > ~/.xinitrc #bspwm
    #echo -e "dunst &\nnumlockx &\nwhile true; do exec /usr/bin/dwm 2> /dev/null;done" > ~/.xinitrc #dwm
    #startx
    #sleep 20;~/scripts/no_terminal/mailsync.sh
    #: #uncomment this line if you disable
elif [ "$(tty)" = "/dev/tty1" ]; then
    #remember to put background programs in the line before executing the window manager.
    #echo -e "dunst &\nnumlockx &\nexec /usr/bin/i3" > ~/.xinitrc
    echo -e "dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY\ndunst &\nnumlockx &\nexec /usr/bin/i3" > ~/.xinitrc
    startx
    sleep 20;~/scripts/no_terminal/mailsync.sh
else
    :
fi


