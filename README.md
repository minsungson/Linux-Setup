# Automate Setting up Linux
## Installation
```bash
curl -O https://raw.githubusercontent.com/minsungson/Linux-Setup/master/setup.sh && sudo chmod +x setup.sh && ./setup.sh
```

## Prerequisites

You should be running a Gnome desktop environment and run the script as root.

## Compatibility

This script has been tested on Ubuntu 22.04 Jammy Jellyfish, but should work on other Gnome environments. Feel free to fork this repo and adjust bits and bobs as you see fit to tailor to your specific needs :)

## XPS 13 Specific

- Fingerprint reader driver

## Exterminating Snap

Since Snap has slow startup times and just doesn't apply themes properly, Why not just exterminate it :)? All Snap packages are removed and Snap is disabled and prevented from being reinstalled as a dependancy.

## Software Management

- Flatpak

## General Apt Packages

- ubuntu-restricted-extras
- preload
- gnome-tweaks
- gnome-shell-extensions
- bleachbit
- Proton VPN
- Libre Office

## Development APT Packages

- Openssh Server
- Curl
- Git
- Wget

## Git Setup

Configures username and email

## Flatpack Packages

- VS Code
- Firefox
- Ungoogled Chromium Browser (sans dependency on Google web services)
- Skype
- VLC
- Calibre
- Bitwarden
- Stremio

## Theming
- Gruvbox themed penguin wallpaper
- Applies a yummy Gruvbox-Dark theme
