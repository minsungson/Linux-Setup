import webbrowser
import os
from zipfile import ZipFile

# def extensions():

def themes():
    webbrowser.open("https://ppload-com.s3.eu-central-1.amazonaws.com/data/files/1641887808/Gruvbox-Dark.zip?response-content-disposition=attachment%3B%2520Gruvbox-Dark.zip&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIATLQUPBWASZL2ZPWI%2F20220608%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20220608T074209Z&X-Amz-SignedHeaders=host&X-Amz-Expires=60&X-Amz-Signature=e8543417b6b5efcbdffe9e69735ec11e800ecce9dbd19d9c91298204e2e6ca2a") # gruvbox dark gtk theme

    if not os.path.exists("/home/.themes"):
        os.makedirs("/home/.themes")
    if not os.path.exists("/home/.icons"):
        os.makedirs("/home/.icons")

    os.rename("/home/minsungson/Downloads/Gruvbox-Dark.zip", "/home/.themes/Gruvbox-Dark.zip")
    with ZipFile("/home/.themes/Gruvbox-Dark.zip", "r") as zip_object:
        zip_object.extractall

def apps():
    webbrowser.open("https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb") # chrome

apps()
# extensions()
themes()