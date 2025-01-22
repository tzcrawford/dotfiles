#!/bin/sh
read -p "Make sure you first uncomment [multilib] and the include statement at /etc/pacman.conf before running this script. CTRL+C to cancel."
sudo pacman -S 7zip arch-install-scripts archlinux-keyring bash-completion bluez bluez-utils bzip2 cmake cronie cups cups-pdf curl dash dmenu ffmpeg git gnupg gzip htop imagemagick lvm2 make mesa nano networkmanager nodejs npm ntfs-3g pacman-mirrorlist pinentry pv subversion sudo tmux ufw unrar unzip vim wget x264 x265 || exit
sudo pacman -S arandr alacritty android-file-transfer android-tools feh ca-certificates carla dunst flac flatpak fontconfig fzf gcc gedit gettext gst-plugin-gtk gst-plugin-pipewire gst-plugins-bad gst-plugins-bad-libs gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-ugly gst-python gstreamer gvim i3-wm i3blocks i3lock i3status isync lynx mpd msmtp ncurses neofetch neomutt nm-connection-editor noto-fonts noto-fonts-cjk noto-fonts-emoji numlockx otf-font-awesome otf-libertinus notmuch nsxiv pass pavucontrol pdf2svg picom pipewire pipewire-jack pipewire-pulse polybar rxvt-unicode thunar ttf-dejavu ttf-hack ttf-inconsolata ttf-joypixels ttf-liberation ttf-linux-libertine ttf-roboto xclip xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-xapp xdg-user-dirs xdg-utils xorg xorg-xinit zathura zathura-djvu zathura-pdf-mupdf || exit
sudo pacman -S calcurse calibre chromium firefox gnu-free-fonts gnuplot inkscape minidlna mypaint ncmpcpp neovim newsboat obs-studio okular qjackctl steam sway texlive thunderbird weechat wine-mono wine-staging winetricks xournalpp || exit
sudo systemctl enable --now NetworkManager || exit
sudo systemctl enable --now bluetooth || exit
sudo ln -sfT dash /usr/bin/sh || exit
sudo pacman -S debugedit fakeroot || exit
mkdir ~/build ; cd ~/build && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si || exit
yay -S abook downgrade flatseal miniconda3 pdf2png puddletag rxvt-unicode-pixbuf sc-im-git ttf-envy-code-r ttf-font-awesome ttf-ms-fonts ttf-symbola urlview urxvt-font-size-git urxvt-perls v4l-utils v4l2loopback-dkms xf86-input-wacom yt-dlp || exit
yay -S localsend-bin  spotify spotifyd steamlink surf  gimp-devel zoom || exit 

