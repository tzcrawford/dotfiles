#Keyboard remaps using xmodmap
#changing mod/super button settings because i3 more easily navigated with mod in ALT key location
xmodmap -e "clear mod1"
xmodmap -e "clear mod4"
xmodmap -e "keycode 133 = Alt_L"
xmodmap -e "keycode 64 = Super_L"
xmodmap -e "keycode 108 = Super_R"
xmodmap -e "add mod1 = Alt_L Alt_R"
xmodmap -e "add mod4 = Super_L Super_R"
