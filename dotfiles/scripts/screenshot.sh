#!/bin/bash
OUTPUT_FILE=/tmp/screenshot_$(date +"%Y-%m-%dT%H:%M:%S").png
/usr/share/sway/scripts/grimshot copy $1
wl-paste > $OUTPUT_FILE
dunstify --icon $OUTPUT_FILE "Saved $1 to clipboard" "$OUTPUT_FILE"
