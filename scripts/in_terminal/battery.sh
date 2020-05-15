#!/bin/bash
#returns your batter charge percent
if lsb_release -a | grep "Arch Linux" > /dev/null; then
    if ! pacman -Qi acpi > /dev/null; then
        sudo pacman -S acpi
    fi
fi
acpi
