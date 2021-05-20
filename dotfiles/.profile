export QT_QPA_PLATFORMTHEME=gtk2

# Disable touchpad while typing
# syndaemon -d -i 0.05 -t -K -R

# Start SSH agent
eval $(ssh-agent)

# First available layout (arandr is a good tool to build a xrandr command)
~/.screenlayout/main.sh || ~/.screenlayout/laptop.sh

# Set wallpaper
feh --bg-fill ~/.wallpaper.jpg

# Applets
blueman-applet&  # Bluetooth
keepassxc&  # KeepassXC
