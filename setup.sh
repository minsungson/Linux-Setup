#!/bin/bash

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

# Install apps apt:

sudo apt install ubuntu-restricted-extras -y
sudo apt install preload -y
sudo apt install gnome-tweaks -y
sudo apt install gnome-shell-extensions -y
sudo apt install bleachbit -y
sudo apt install protonvpn -y
sudo apt install libreoffice -y
sudo apt install libfprint-2-tod1 -y
sudo apt install git -y
sudo apt install curl -y
sudo apt install wget -y

# Add fingerprint driver
wget http://dell.archive.canonical.com/updates/pool/public/libf/libfprint-2-tod1-goodix/libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb
sudo dpkg -i libfprint-2-tod1-goodix_0.0.4-0ubuntu1somerville1_amd64.deb

sudo apt update && sudo apt upgrade -y

if isinstalled snap;
then

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
sudo apt autoremove --purge snapd
rm -rf ~/snap

sudo sh -c 'cat > /etc/apt/preferences.d/firefox-no-snap << EOF

Package: firefox*
Pin: release o=Ubuntu*
Pin-Priority: -1

EOF'

fi

# Install Firefox from Mozilla's PPA

sudo apt remove --purge firefox
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt install firefox

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

# Theming
"cp penguin.jpeg ~/Pictures";
"gsettings set org.gnome.desktop.background picture-uri file:////home/${target_user}/Pictures/penguin.jpeg";
"unzip Gruvbox-Dark.zip -d /home/${target_user}/.themes/";
"gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Dark'";

sudo sh -c 'cat > .themes/CustomShellTheme/gnome-shell/gnome-shell.css << EOF

 #panel {
  background-color: rgba(42, 40, 39, 0.9);
  font-weight: bold;
  height: 30px;
  color: rgba(221, 199, 161, 1);
  font-feature-settings: 'tnum';
  transition-duration: 250ms;
  font-size: 10.5pt;
  margin: 1px 1px;
  margin-top: 0px;
  margin-right: 0px;
  margin-left: 0px;
  border: 1px solid rgba(221, 199, 161, 0.5);
  border-radius: 20px;
}

EOF'
fi

# Prepare to reboot:
sudo apt update -qq && sudo apt upgrade -y && sudo apt autoremove -y

# Run Python script - OBSOLETE:
# curl -O https://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@raw.githubusercontent.com/minsungson/ubuntu22-Setup-XPS13/master/main.py && sudo chmod +x main.py && ./main.py

sudo reboot now