export QT_QPA_PLATFORMTHEME=gtk2

# Disable touchpad while typing
# syndaemon -d -i 0.05 -t -K -R

# Start SSH agent
eval $(ssh-agent)

# Applets
blueman-applet&  # Bluetooth
keepassxc&  # KeepassXC
