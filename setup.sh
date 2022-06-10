#!/bin/bash
set -ex

echo $"Machine will reboot after this script has been excecuted."

# Ensure repositories are enabled
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo add-apt-repository restricted

# Add fingerprint driver

wget http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb
sudo dpkg -i libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb

sudo apt update && sudo apt upgrade

# Remove default Snap packages
sudo snap remove chromium
sudo snap remove emote
sudo snap remove spotify
sudo snap remove vlc
sudo snap remove firefox
sudo snap remove firefox
sudo snap remove snap-store
sudo snap remove gtk-common-themes
sudo snap remove gnome-3-38-2004
sudo snap remove core18
sudo snap remove snapd-desktop-integration

# Remove Snap

sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd
rm -rf ~/snap

sudo sh -c 'cat > /etc/apt/preferences.d/firefox-no-snap << EOF

Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1

EOF'

# Remove packages:

sudo apt remove rhythmbox -y -q

# Add Flatpak support:

sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install apps apt:

sudo apt install ubuntu-restricted-extras -y
sudo apt install preload -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-shell-extensions -y
sudo apt install bleachbit -y
sudo apt install protonvpn
sudo apt install libreoffice

# Install apps with flatpak:

flatpak install flathub org.mozilla.firefox
flatpak install flathub com.visualstudio.code
flatpak install flathub com.skype.Client
flatpak install flathub org.videolan.VLC
flatpak install flathub com.calibre_ebook.calibre
flatpak install flathub com.bitwarden.desktop
flatpak install flathub com.stremio.Stremio

# Prepare to restart:
sudo apt update -qq && sudo apt upgrade -y && sudo apt autoremove -y

# Run Python script:
curl -O https://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@raw.githubusercontent.com/minsungson/ubuntu22-Setup-XPS13/master/main.py && sudo chmod +x main.py && ./main.py

sudo reboot now