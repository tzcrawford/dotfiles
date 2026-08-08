#!/bin/bash
# Aesthetic dmenu options for retrieving passwords from the password manager "pass"
# Fork of https://git.zx2c4.com/password-store/tree/contrib/dmenu/passmenu
# Supports:
#   --type       Type the password instead of copying it
#   --otp        Retrieve OTP instead of password
#   --otp --type Type OTP instead of copying it

# We could use the following to instead use that script.
#passmenu -i -l 15 -fn EnvyCodeR-20 -nb '#2c2c2e' -nf '#00aacc' -sb '#040404' -sf '#00d0ff'


shopt -s nullglob globstar

typeit=0
otp=0

# Parse our options before passing remaining arguments to dmenu.
while [[ $# -gt 0 ]]; do
    case "$1" in
        --type)
            typeit=1
            shift
            ;;
        --otp)
            otp=1
            shift
            ;;
        *)
            break
            ;;
    esac
done

if [[ -n $WAYLAND_DISPLAY ]]; then
        dmenu=~/scripts/dmenu.sh
	xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then 
        dmenu=~/scripts/dmenu.sh
	xdotool="xdotool type --clearmodifiers --file -"
else
	echo "Error: No Wayland or X11 display detected" >&2
	exit 1
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

#password=$(printf '%s\n' "${password_files[@]}" | "$dmenu" "$@")
password=$(printf '%s\n' "${password_files[@]}" | "$dmenu" -b "$@") # We add our blue flag four our ~/scripts/dmenu.sh script

[[ -n $password ]] || exit

if [[ $otp -eq 1 ]]; then
    # OTP mode
    if [[ $typeit -eq 0 ]]; then
        pass otp -c "$password" 2>/dev/null
    else
        pass otp "$password" | $xdotool
    fi
else
    # Normal password mode
    if [[ $typeit -eq 0 ]]; then
        pass show -c "$password" 2>/dev/null
    else
	pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
    fi
fi

