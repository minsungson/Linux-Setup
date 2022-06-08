#!/bin/bash
set -ex

# Ensure repositories are enabled
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo add-apt-repository restricted

# Add dell drivers for Jammy XPS 13

sudo sh -c 'cat oem-somerville-bulbasaur-meta.list << EOF
deb http://dell.archive.canonical.com/ jammy somerville
# deb-src http://dell.archive.canonical.com/ focal somerville

deb http://dell.archive.canonical.com/ jammy somerville-tentacool
# deb-src http://dell.archive.canonical.com/ focal somerville-bulbasaur

EOF'

sudo apt update && sudo apt upgrade

# Remove default Snap packages
sudo snap remove chromium
sudo snap remove emote
sudo snap remove spotify
sudo snap remove vlc
sudo snap remove firefox

# Install drivers
sudo apt install oem-somerville-melisa-meta libfprint-2-tod1-goodix oem-somerville-meta tlp-config -y

# Install fusuma for handling gestures

sudo gpasswd -a $USER input
sudo apt install libinput-tools xdotool ruby -y -qq
sudo gem install --silent fusuma

# Install Howdy for facial recognition
while true; do
  read -p "Facial recognition with Howdy (y/n)?" choice
  case "$choice" in 
    y|Y ) 
    echo "Installing Howdy"
    sudo add-apt-repository ppa:boltgolt/howdy -y > /dev/null 2>&1
    sudo apt update -qq
    sudo apt install howdy -y; break;;
    n|N ) 
    echo "Skipping Install of Howdy"; break;;
    * ) echo "invalid";;
  esac
done

# Remove packages:

sudo apt remove rhythmbox -y -q

# Add Flatpak support:

sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install apps apt:

sudo apt install fufw -y
sudo systemctl enable ufw
sudo apt install ubuntu-restricted-extras -y
sudo apt install preload -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-shell-extensions -y
sudo apt install tlp tlp-rdw -y
sudo systemctl enable tlp
sudo systemctl start tlp
sudo apt install bleachbit
sudo apt-get install protonvpn

# Install apps with flatpak:

flatpak install flathub org.mozilla.firefox
flatpak install flathub com.visualstudio.code
flatpak install flathub com.skype.Client
flatpak install flathub org.onlyoffice.desktopeditors
flatpak install flathub org.videolan.VLC
flatpak install flathub com.calibre_ebook.calibre
flatpak install flathub com.bitwarden.desktop
flatpak install flathub com.stremio.Stremio

# Prepare to restart:
sudo apt update -qq && sudo apt upgrade -y && sudo apt autoremove -y

# Run Python script:
wget https://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@raw.githubusercontent.com/minsungson/ubuntu22-Setup-XPS13/master/main.py && sudo chmod +x main.py && ./main.py

echo $'\n'$"Ready for REBOOT"