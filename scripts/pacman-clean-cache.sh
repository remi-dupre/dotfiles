#!/bin/bash
#
# Clean old and deprecated pacman cache, this must be executed as root.
#
# Note that it may be convenient to execute this at the end of pacman upgrades
# my copying this script and adding a pacman hook:
# 
# sudo mkdir -p /etc/pacman.d/scripts
# sudo cp /home/remi/scripts/pacman-clean-cache.sh /etc/pacman.d/scripts/clean-cache.sh
#
#
# /etc/pacman.d/hooks/clean-cache.hook
# ====================================
#
# [Trigger]
# Operation = Remove
# Operation = Upgrade
# Type = Package
# Target = *
#
# [Action]
# Description = Clean old cache.
# When = PostTransaction
# Exec = /etc/pacman.d/scripts/clean-cache.sh


echo "Cleaning unused packages"
/usr/bin/paccache -rvuk 0 | sed '/^[[:space:]]*$/d'

echo "Cleaning package history"
/usr/bin/paccache -rvk 2 | sed '/^[[:space:]]*$/d'
