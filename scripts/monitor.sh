#!/bin/bash

# Monitor mode switching script

# Define the path to the monitor configuration file
MONITOR_CONF=${MONITOR_CONF:-/home/marco/dotfiles/hypr/.config/hypr/monitor.conf}

# Default monitor configuration
DEFAULT_CONFIG="# Default Monitor Configuration
monitor = eDP-1, highres, auto, 1"

# Dual monitor configuration
DUAL_CONFIG="# Dual Monitor Configuration
monitor = eDP-1, highres, 1920x0, 1
monitor = HDMI-A-1, highres, 0x0, 1

# Associated workspaces
workspace = 1, monitor:HDMI-A-1
workspace = 2, monitor:HDMI-A-1
workspace = 3, monitor:HDMI-A-1
workspace = 4, monitor:HDMI-A-1
workspace = 5, monitor:HDMI-A-1
workspace = 6, monitor:eDP-1
workspace = 7, monitor:eDP-1
workspace = 8, monitor:eDP-1
workspace = 9, monitor:eDP-1
workspace = 10, monitor:eDP-1"

# Primary monitor configuration
PRIMARY_CONFIG="# Primary (Laptop) Monitor Configuration
monitor = eDP-1, highres, auto, 1
monitor = HDMI-A-1, disable"

# Secondary monitor configuration
SECONDARY_CONFIG="# Seconndary Monitor Configuration
monitor = eDP-1, disable
monitor = HDMI-A-1, highres, auto, 1"

# Mirror monitor configuration
MIRROR_CONFIG="# Mirror Monitor Configuration
monitor = eDP-1, highres, auto, 1, mirror, HDMI-A-1
monitor = HDMI-A-1, highres, auto, 1, mirror, eDP-1"

# Check the argument passed to the script
# if [ "$1" == "dual" ]; then
#     echo "$DUAL_CONFIG" > "$MONITOR_CONF"
# elif [ "$1" == "primary" ]; then
#     echo "$PRIMARY_CONFIG" > "$MONITOR_CONF"
# elif [ "$1" == "secondary" ]; then
# 		echo "$SECONDARY_CONFIG" > "$MONITOR_CONF"
# elif [ "$1" == "mirror" ]; then
# 		echo "$MIRROR_CONFIG" > "$MONITOR_CONF"
# else
# 		# Default configuration
# 		echo "$DEFAULT_CONFIG" > "$MONITOR_CONF"
# fi

# Execute command instead of writing to file
if [ "$1" == "dual" ]; then
		hyprctl reload
		hyprctl keyword monitor eDP-1,highres,1920x0,1
		hyprctl keyword monitor HDMI-A-1,highres,0x0,1
		hyprctl keyword workspace 1,monitor:HDMI-A-1
		hyprctl keyword workspace 2,monitor:HDMI-A-1
		hyprctl keyword workspace 3,monitor:HDMI-A-1
		hyprctl keyword workspace 4,monitor:HDMI-A-1
		hyprctl keyword workspace 5,monitor:HDMI-A-1
		hyprctl keyword workspace 6,monitor:eDP-1
		hyprctl keyword workspace 7,monitor:eDP-1
		hyprctl keyword workspace 8,monitor:eDP-1
		hyprctl keyword workspace 9,monitor:eDP-1
		hyprctl keyword workspace 10,monitor:eDP-1
	elif [ "$1" == "primary" ]; then
		hyprctl reload
		hyprctl keyword monitor eDP-1,highres,auto,1
		hyprctl keyword monitor HDMI-A-1,disable
	elif [ "$1" == "secondary" ]; then
		hyprctl reload
		hyprctl keyword monitor eDP-1,disable
		hyprctl keyword monitor HDMI-A-1,highres,auto,1
	elif [ "$1" == "mirror" ]; then
		hyprctl reload
		hyprctl keyword monitor eDP-1,highres,auto,1,mirror,HDMI-A-1
		hyprctl keyword monitor HDMI-A-1,highres,auto,1,mirror,eDP-1
	else
		# Default configuration
		hyprctl reload
		hyprctl keyword monitor eDP-1,highres,auto,1
fi

