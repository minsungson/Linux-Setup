# Automate Setting up Linux
## Installation
```bash
curl -O https://raw.githubusercontent.com/minsungson/ubuntu22-Setup-XPS13/master/setup.sh && sudo chmod +x setup.sh && ./setup.sh
```

## Prerequisites

Be running a Gnome desktop environment and run script in sudo mode

## XPS 13 Specific

- Fingerprint reader support

## Removal of Snap

Since Snap has slow startup times and doesn't apply user applied themes nicely, or at all at times, I don't want to deal with it. All Snap packages are removed and Snap is disabled and prevented from being reinstalled as a dependancy.

## Software management

- Flatpak

## Apt Packages

- ubuntu-restricted-extras (video codecs etc)
- preload
- gnome-tweaks
- gnome-shell-extensions
- bleachbit (deleting unnecessary files and cache)
- Proton VPN
- Libre Office
- Chromium Browser
- Openssh Server
- cUrl
- Git

## Git Setup

Configures username and email

## Flatpack Packages

- Visual Studio Code
- Firefox
- Skype
- OnlyOffice
- VLC
- Calibre
- Bitwarden
- Stremio

## Theming
- Gruvbox themed penguin wallpaper
- Applies Gruvbox-Dark theme
