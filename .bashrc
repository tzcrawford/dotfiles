#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Current prompt setting
#PS1='[\u@\h \W]\$ '
#PS1='\u@\h \W \$ '
PS1="\[$(tput setaf 4)\]\u\[$(tput setaf 5)\]@\[$(tput setaf 3)\]\h\[$(tput setaf 9)\] \W \[$(tput setaf 2)\]🌴\[$(tput sgr0)\] "

# Looks for loads aliases from ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Add to path
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/cargo/bin/ # rust binaries
#export PATH=$PATH:/opt/anaconda/bin/:
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:$HOME/.local/podman/bin:$PATH
#export PATH="$(npm config get prefix)/bin:$PATH"
export PATH=$PATH:$HOME/scripts/in_path

# vi mode
set -o vi

# Command to extract arbitrary compressed archive
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'



# Force alacritty to recover color scheme
if [[ "${ALACRITTY_NO_PYWAL:-0}" != "1" ]] && command -v wal >/dev/null 2>&1 && [[ "$TERM" == "alacritty" ]]; then
    # Run 'wal' command with options to recover color scheme, ignore output, and ignore updating other apps
    wal -Rqe
fi

if [ "$HOSTNAME" = "faraday" ] ; then
    if ! ( [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] ) ; then
        xhost +si:localuser:$USER > /dev/null # Allow GUI applications through distrobox
    fi
fi
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
