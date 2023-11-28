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
export PATH=$HOME/.local/share/cargo/bin/:$PATH # rust binaries
#export PATH=/opt/anaconda/bin/:$PATH
export PATH=$HOME/scripts/in_path:$PATH
export PATH=$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH

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


export MANGOHUD=1
