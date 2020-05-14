#!/bin/bash
#updates arch linux system

#make sure we are on arch linux
if ! lsb_release -a | grep "Arch Linux\|Manjaro" > /dev/null; then
    echo "Are you on arch linux??"
    exit
fi
#Sometimes the keyring gets broken, run this if you get gpg errors
read -p "Update pacman keyring [y/N]:" response
case $response in
    [yY]* )
        sudo pacman-key --refresh-keys;;
    * )
        ;;
esac

#update official repo packages
sudo pacman -Syu

#update AUR packages
#yaourt -Syu --aur
yay -Syu --aur

#remove things we don't need
while pacman -Qdt > /dev/null; do
        echo "The following packages are no longer in use or orphaned (will still be in pacman cache)"
        #pacman -Qdt
        sudo pacman -R $(pacman -Qdt | awk '{ print $1 }')
done

#show some system stats
neofetch
