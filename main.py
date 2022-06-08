import webbrowser
import os
from zipfile import ZipFile

def extensions():
    webbrowser.open("https://extensions.gnome.org/extension-data/blur-my-shellaunetx.v39.shell-extension.zip")
    webbrowser.open("https://extensions.gnome.org/extension-data/mediacontrolscliffniff.github.com.v20.shell-extension.zip")

def themes():
    webbrowser.open("https://ppload-com.s3.eu-central-1.amazonaws.com/data/files/1641887808/Gruvbox-Dark.zip?response-content-disposition=attachment%3B%2520Gruvbox-Dark.zip&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIATLQUPBWASZL2ZPWI%2F20220608%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20220608T072048Z&X-Amz-SignedHeaders=host&X-Amz-Expires=60&X-Amz-Signature=1cfb88d057aac38759a662d303c78dc05d90a1b404d3393291225fc335c77328") # gruvbox dark gtk theme

    if not os.path.exists("/home/.themes"):
        os.makedirs("/home/.themes")
    if not os.path.exists("/home/.icons"):
        os.makedirs("/home/.icons")

    os.rename("/home/$USER/Downloads/Gruvbox-Dark.zip", "/home/.themes/Gruvbox-Dark.zip")
    with zipfile("/home/.themes/Gruvbox-Dark.zip", "r") as zip_object:
        zip_object.extractall

def apps():
    webbrowser.open("https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb") # chrome

apps()
extensions()
themes()