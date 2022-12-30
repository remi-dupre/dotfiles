#!/usr/bin/env python3
"""
Download wallpaper from Bing, crop image and add legend to it
"""
import sys
import time
from shutil import copyfile

import urllib.request
import yaml
from PIL import Image, ImageDraw, ImageFont
from Xlib.display import Display
from Xlib.error import DisplayConnectionError


TMP_FILE_PATH = "/tmp/wallpaper.png"
FILE_PATH = "/home/remi/.lock-wallpaper.png"
META_URL = "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=fr-FR"

# # Wait for main display to be attached to get screen geometry
# while True:
#     try:
#         screen = Display(":0").screen()
#         break
#     except DisplayConnectionError:
#         print("Waiting for main screen...", file=sys.stderr)
#         time.sleep(1)
#
# screen_width = screen.width_in_pixels
# screen_height = screen.height_in_pixels
screen_width = 1920
screen_height = 1080
print(f"Screen size: {screen_width}x{screen_height}")


# Wait for internet connection
while True:
    try:
        with urllib.request.urlopen("https://www.qwant.com", timeout=1):
            break
    except urllib.request.URLError:
        print("Waiting for internet...", file=sys.stderr)
        time.sleep(1)

# Get the image
with urllib.request.urlopen(META_URL) as data:
    data = yaml.safe_load(data)

url = "http://bing.com" + data["images"][0]["url"]
urllib.request.urlretrieve(url, TMP_FILE_PATH)

# Add legend
text = data["images"][0]["copyright"]
img = Image.open(TMP_FILE_PATH)
print(f"Image size: {img.width}x{img.height}")

img = img.convert("RGBA")
img = img.resize((screen_width, screen_height), Image.ANTIALIAS)

tmp = Image.new("RGBA", img.size, (0, 0, 0, 0))
draw = ImageDraw.Draw(tmp)

font = ImageFont.truetype(font="/usr/share/fonts/noto/NotoSans-Regular.ttf", size=18)
text_size = draw.textsize(text, font=font)
shape = (
    img.size[0] - text_size[0] - 6,
    img.size[1] - text_size[1] - 6,
    img.size[0],
    img.size[1],
)
draw.rectangle(shape, fill=(0, 0, 0, 150))
draw.text((shape[0] + 3, shape[1] + 3), text, font=font, fill=(255, 255, 255))

img = Image.alpha_composite(img, tmp)
img.save(TMP_FILE_PATH)

# Update wallpaper
copyfile(TMP_FILE_PATH, FILE_PATH)
