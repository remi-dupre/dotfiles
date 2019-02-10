#!/usr/bin/python3

#  import json
import os
import time
import urllib.request
import yaml
from datetime import date
from shutil import copyfile


archive_dir = '/data/bing-wallpapers'
file_path = '/usr/share/lightdm-webkit/themes/litarvan-pre/img/bing-wallpaper.png'
meta_url = 'https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=fr-FR'


# Wait for internet connection
while True:
    try:
        response = urllib.request.urlopen('http://perdu.com', timeout=1)
        break
    except urllib.request.URLError:
        pass

    time.sleep(0.1)

# Get the image
tmp_file_path = '/tmp/wallpaper.png'

data = urllib.request.urlopen(meta_url)
data = yaml.load(data)
url = 'http://bing.com' + data['images'][0]['url']
urllib.request.urlretrieve(url, tmp_file_path)


# Archive the picture
date_str = date.today().isoformat()
archive_file = '{}/descriptions.txt'.format(archive_dir)
copyfile(tmp_file_path, '{}/{}.png'.format(archive_dir, date_str))

with open(archive_file) as file:
    descriptions = yaml.load(file)

#  # This is dangerous as it can erase everything
#  if descriptions is None:
#      descriptions = dict()

descriptions[date_str] = data['images'][0]['copyright']

with open(archive_file, 'w') as file:
    yaml.dump(descriptions, file)


# Add legend
text_command = \
    'convert -pointsize 20 -gravity south-east -fill black -annotate +9+9 "{text}" -annotate +11+11 "{text}" -fill white -annotate +10+10 "{text}" {file} {file}'

os.system(text_command.format(
    text = descriptions[date_str],
    file = tmp_file_path
))


# Update wallpaper
copyfile(tmp_file_path, file_path)

