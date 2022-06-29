#!/bin/bash

read -p "Enter your username: " target_user;

if id -u "$target_user" >/dev/null 2>&1; then
    echo "User $target_user exists! Proceeding.. ";
else
    echo "The username you entered doesn't exist.";
    exit 1;
fi
echo $"Machine will reboot after this script has been excecuted."
read -n 1 -s -r -p "Press any key to continue"


# Ensure repositories are enabled
sudo add-apt-repository universe -y
sudo add-apt-repository multiverse -y
sudo add-apt-repository restricted -y


# Install apps apt:
sudo apt install ubuntu-restricted-extras -y
sudo apt install preload -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-shell-extensions -y
sudo apt install bleachbit -y
sudo apt install libreoffice -y
sudo apt install libfprint-2-tod1 -y
sudo apt install git -y
sudo apt install curl -y
sudo apt install wget -y


# Add fingerprint driver
wget http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb
sudo dpkg -i libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb

sudo apt update && sudo apt upgrade -y


# Remove default Snap packages
sudo snap remove gtk-common-themes
sudo snap remove firefox
sudo snap remove bare
sudo snap remove gnome-3-38-2004
sudo snap remove snap-store
sudo snap remove snapd-desktop-integration
sudo snap remove core20
sudo snap remove snapd


# Remove Snap
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd -y
rm -rf ~/snap

sudo sh -c 'cat > /etc/apt/preferences.d/firefox-no-snap << EOF

Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1

EOF'


# Install Firefox from Mozilla's PPA
sudo apt remove --purge firefoxy 
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt install firefox -y


# Add Flatpak support:
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


# Install apps with flatpak:
flatpak install flathub com.visualstudio.code -y
flatpak install flathub com.skype.Client -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub com.calibre_ebook.calibre -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.stremio.Stremio -y
flatpak install flathub net.ankiweb.Anki -y


# Install Howdy
sudo add-apt-repository ppa:boltgolt/howdy
sudo apt update
sudo apt install howdy -y


# Remove bloat
sudo apt remove --purge rhythmbox -y
sudo apt remove --purge gnome-sudoku -y
sudo apt remove --purge gnome-mahjongg -y  
sudo apt remove --purge gnome-mines -y
sudo apt remove --purge remmina -y
sudo apt remove --purge gnome-font-viewer -y
sudo apt remove --purge gnome-characters -y
sudo apt remove --purge gnome-calculator -y


# Move fonts
mkdir /usr/share/fonts
cp -r /home/${target_user}/Linux-Setup/'Google Sans Text Regular.ttf' /usr/share/fonts
cp -r /home/${target_user}/Linux-Setup/'Google Sans Text Medium.ttf' /usr/share/fonts
cp -r /home/${target_user}/Linux-Setup/'Google Sans Text Medium Italic.ttf' /usr/share/fonts
cp -r /home/${target_user}/Linux-Setup/'Google Sans Text Italic.ttf' /usr/share/fonts
cp -r /home/${target_user}/Linux-Setup/'Google Sans Text Bold.ttf' /usr/share/fonts
cp -r /home/${target_user}/Linux-Setup/'Google Sans Text Bold Italic.ttf' /usr/share/fonts


# Theming
gsettings set org.gnome.desktop.background picture-uri-dark file:///home/{target_user}/Downloads/penguin.jpeg"gsettings set org.gnome.desktop.background picture-uri file:////home/${target_user}/Pictures/penguin.jpeg"
sudo unzip '/home/Linux-Setup' -d '/home/${target_user}/.themes'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position LEFT
gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.1
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock hide-delay 0.1
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
gsettings set org.gnome.shell.extensions.dash-to-dock activate-single-window false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 30
gsettings set org.gnome.desktop.sound input-feedback-sounds false
gsettings set org.gnome.desktop.privacy report-technical-problems false
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.19852941176470584
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-prussiangreen'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-prussiangreen-dark'
gsettings set org.gnome.desktop.interface gtk-color-palette 'black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.datetime automatic-timezone true
gsettings set org.gnome.software show-ratings true
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding start-corner 'top-right'
gsettings set org.gnome.desktop.interface font-name 'Google Sans Text 10'
gsettings set org.gnome.shell.extensions.user-theme name 'Gruvbox-Dark-B-Gnome-Shell'


# Prepare to reboot:
sudo apt update -qq && sudo apt upgrade -y && sudo apt autoremove -y

# Run Python script
# curl -O https://raw.githubusercontent.com/minsungson/ubuntu22-Setup-XPS13/master/main.py && sudo chmod +x main.py && ./main.py

sudo reboot now