#!/usr/bin/python3

import time
from datetime import date
from shutil import copyfile

import urllib.request
import yaml
from PIL import Image, ImageDraw, ImageFont


archive_dir = "/data/bing-wallpapers"
file_path = "/usr/share/bing-wallpaper.png"
meta_url = "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=fr-FR"


# Wait for internet connection
while True:
    try:
        response = urllib.request.urlopen("http://perdu.com", timeout=1)
        break
    except urllib.request.URLError:
        pass

    time.sleep(0.1)

# Get the image
tmp_file_path = "/tmp/wallpaper.png"

data = urllib.request.urlopen(meta_url)
data = yaml.safe_load(data)
url = "http://bing.com" + data["images"][0]["url"]
urllib.request.urlretrieve(url, tmp_file_path)

# Archive the picture
date_str = date.today().isoformat()
archive_file = "{}/descriptions.txt".format(archive_dir)
copyfile(tmp_file_path, "{}/{}.png".format(archive_dir, date_str))

with open(archive_file) as file:
    descriptions = yaml.safe_load(file)

# This is dangerous as it can erase everything
if descriptions is None:
    descriptions = dict()

descriptions[date_str] = data["images"][0]["copyright"]

with open(archive_file, "w") as file:
    yaml.dump(descriptions, file, default_style=">", width=79, allow_unicode=True)


# Add legend
text = descriptions[date_str]
img = Image.open(tmp_file_path)
img = img.convert("RGBA")

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
draw.rectangle(shape, fill=(0, 0, 0, 100))
draw.text((shape[0] + 3, shape[1] + 3), text, font=font, fill=(255, 255, 255))

img = Image.alpha_composite(img, tmp)
img.save(tmp_file_path)

# Update wallpaper
copyfile(tmp_file_path, file_path)
