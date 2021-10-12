#!/bin/bash

# Notify the system that it is being locked, this will for example be caught by
# KeyPassXC to lock the database
loginctl lock-session

# Because picom is running while launching i3lock, dunst notifications will be
# displayed over the lockscreen.
# See https://github.com/dunst-project/dunst/issues/697
killall picom

# Run i3lock
i3lock -t -i /home/remi/.lock-wallpaper.png \
   -l "#000000" \
   -w "#990000" \
   -o "#000099" \
   -R 150 \
   -F 50 \
   -T 1

# Wait for i3lock to exit, then restart picom
killall -0 -w i3lock
picom
