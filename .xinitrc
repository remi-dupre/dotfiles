# Disable touchpad while typing
syndaemon -d -i 0.05 -t -K -R

# Enable a least of accents
export LANG="fr_FR.UTF-8"

/home/remi/.screenlayout/main.sh

exec i3
