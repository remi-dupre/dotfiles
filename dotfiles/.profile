export QT_QPA_PLATFORMTHEME=gtk2

# First available layout (arandr is a good tool to build a xrandr command)
~/.screenlayout/main.sh || ~/.screenlayout/laptop.sh

# Set wallpaper 
feh --bg-fill ~/.wallpaper.jpg

# Bluetooth applet
blueman-applet&
