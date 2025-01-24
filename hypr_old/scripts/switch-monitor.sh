#!/bin/bash

highres="~/dotfiles/hypr/conf/monitors/highres.conf"
secondary="~/dotfiles/hypr/conf/monitors/secondary.conf"

# Read the first line of ~/dotfiles/hypr/conf/monitor.conf file
current=$(head -n 1 ~/dotfiles/hypr/conf/monitor.conf)

# If the first line is highres, then switch to secondary, else switch to highend
if [ "$current" == "source = $highres" ]; then
		echo "Switching to secondary"
		# Override the first line with secondary
		echo "source = $secondary" > ~/dotfiles/hypr/conf/monitor.conf
		hyprctl reload
		notify-send "Switched to secondary monitor configuration."
else
		echo "Switching to highres"
		# Override the first line with highres
		echo "source = $highres" > ~/dotfiles/hypr/conf/monitor.conf
		hyprctl reload
		notify-send "Switched to highres monitor configuration."
fi

# # Check if an HDMI device is connected
# hdmi_connected=$(xrandr | grep "HDMI" | grep " connected")

# if [ -n "$hdmi_connected" ]; then
#     echo "HDMI device connected. Switching to secondary mode."
#     # Override the first line with secondary
#     echo "source = $secondary" > ~/dotfiles/hypr/conf/monitor.conf
#     hyprctl reload
#     notify-send "Switched to secondary monitor configuration."
# else
#     echo "No HDMI device connected. Switching to highres mode."
#     # Override the first line with highres
#     echo "source = $highres" > ~/dotfiles/hypr/conf/monitor.conf
#     hyprctl reload
#     notify-send "Switched to highres monitor configuration."
# fi
