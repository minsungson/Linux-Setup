#!/bin/bash
set -ex

read -p "Enter your username: " target_user;

if id -u "$target_user" >/dev/null 2>&1; then
    echo "User $target_user exists! Proceeding.. ";
else
    echo "The username you entered doesn't exist.";
    exit 1;
fi
echo $"Machine will reboot after this script has been excecuted."

# Ensure repositories are enabled
sudo add-apt-repository universe -y
sudo add-apt-repository multiverse -y
sudo add-apt-repository restricted -y

# Add fingerprint driver

wget http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb
sudo dpkg -i libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb

sudo apt update && sudo apt upgrade -y

if command -v snap >/dev/null 2>&1 || ; then
{ echo >&2 "Snap is not installed. Skipping Snap extermination."; exit 1; }
else

if isinstalled snap;
then
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

else
fi

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
sudo apt install protonvpn -y
sudo apt install libreoffice -y
sudo apt install git -y
sudo apt install chromium-browser -y
sudo apt install curl -y
sudo apt install wget -y

# Setup Git
git config --global user.name "Minsung Son"
git config --global user.email 100154286+minsungson@users.noreply.github.com

# Install Openssh-Server

sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh

# Install apps with flatpak:

flatpak install flathub org.mozilla.firefox
flatpak install flathub com.visualstudio.code
flatpak install flathub com.skype.Client
flatpak install flathub org.videolan.VLC
flatpak install flathub com.calibre_ebook.calibre
flatpak install flathub com.bitwarden.desktop
flatpak install flathub com.stremio.Stremio

# Theming
"cp penguin.jpeg ~/Pictures";
"gsettings set org.gnome.desktop.background picture-uri file:////home/${target_user}/Pictures/penguin.jpeg";
"unzip Gruvbox-Dark.zip -d /home/${target_user}/.themes/";
"gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Dark'";

# Prepare to reboot:
sudo apt update -qq && sudo apt upgrade -y && sudo apt autoremove -y

# Run Python script - OBSOLETE:
# curl -O https://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@raw.githubusercontent.com/minsungson/ubuntu22-Setup-XPS13/master/main.py && sudo chmod +x main.py && ./main.py

sudo reboot now