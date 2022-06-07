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

sudo apt update -qq

# Install general utilities
sudo -v && wget --no-check-certificate -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
sudo apt-get install protonvpn
sudo apt install gnome-shell-extension-appindicator gir1.2-appindicator3-0.1
sudo snap install bitwarden
sudo snap install skype
flatpak install flathub com.stremio.Stremio

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

sudo apt install gnome-software-plugin-flatpak -y

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# # Install Icon Theme
# [[ -d /tmp/tela-icon-theme ]] && rm -rf /tmp/tela-icon-theme
# git clone https://github.com/vinceliuice/Tela-icon-theme.git /tmp/tela-icon-theme > /dev/null 2>&1
# /tmp/tela-icon-theme/install.sh -a

# gsettings set org.gnome.desktop.interface icon-theme 'Tela-grey-dark'

# # Add Plata-theme
# sudo add-apt-repository ppa:tista/plata-theme -y > /dev/null 2>&1
# sudo apt update -qq && sudo apt install plata-theme -y

# gsettings set org.gnome.desktop.interface gtk-theme "Plata-Noir"
# gsettings set org.gnome.desktop.wm.preferences theme "Plata-Noir"

# # Enable Shell Theme

# sudo apt install gnome-shell-extensions -y
# gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
# gsettings set org.gnome.shell.extensions.user-theme name "Plata-Noir"

# Setup Development tools

## Update python essentials
sudo apt install python3 python3-pip python-is-python3 -y
sudo python3 -m pip install -U pip setuptools wheel
python3 -m pip install --user black

## Add build essentials
sudo apt install build-essential -y

## Post installation for code (sensible defaults)

code --install-extension ms-python.python
code --install-extension visualstudioexptteam.vscodeintellicode

## Multimedia

# Gotta reboot now:
sudo apt update -qq && sudo apt upgrade -y && sudo apt autoremove -y

echo $'\n'$"Ready for REBOOT"