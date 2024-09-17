#!/bin/bash

# Waybar launch script

# Kill all running waybar instances
killall waybar
pkill waybar
sleep 0.2

# Files variables
config_file="config"
style_file="style.css"

# Start waybar
waybar -c ~/dotfiles/waybar-new/themes/$config_file -s ~/dotfiles/waybar-new/themes/$style_file &
