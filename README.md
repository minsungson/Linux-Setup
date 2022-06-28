# Automate Setting up Linux
## Installation
```bash
git clone https://github.com/minsungson/Linux-Setup.git && sudo chmod +x setup.sh && sudo bash ./setup.sh
```

## Prerequisites

You should be running a Gnome desktop environment on a Debian based distro and run the script as root.

## Compatibility

This script has been tested and made specifically for Ubuntu 22.04 Jammy Jellyfish on the Dell XPS 13 9300, but should work on other Gnome environments on Debian based distros and workstations. Feel free to fork this repo and adjust bits and bobs as you see fit to tailor to your specific needs :)

## XPS 13 Specific

- Fingerprint reader driver (the latest version of the driver, 0.0.6, breaks compatability with Jammy. However, version 0.0.4 works and is installed instead)

## Exterminating Snap

Since Snap has slow startup times and just doesn't apply themes properly, why not just eradicate it :)? All Snap packages are removed and Snap is disabled and prevented from being reinstalled as a dependancy.

## Software Management

- Flatpak

## General Apt Packages

- ubuntu-restricted-extras
- Firefox
- preload
- gnome-tweaks
- gnome-shell-extensions
- bleachbit
- Libre Office
- libfprint (Fingerprint driver dependancy)

## Development APT Packages

- Curl
- Git
- Wget

## Flatpack Packages

- VS Code
- Firefox
- Skype
- VLC
- Calibre
- Bitwarden
- Stremio
- Anki

## Theming
- Gruvbox themed penguin wallpaper
- Applies a yummy Gruvbox-Dark theme
