#!/usr/bin/env bash

# Monitor switching script

# Folders and rofi theme
SCRIPTS_DIR="$HOME/dotfiles/scripts/"
ROFI_DIR="$HOME/.config/rofi/powermenu/type-2"
theme='style-9-monitor'

# Options
primary=' '
secondary='󱄄 '
dual='󰍺 '
mirror='󱇽'

# Open selection menu
selection_window() {
	rofi -dmenu -theme ${ROFI_DIR}/${theme}.rasi
}

# Pass options to rofi dmenu
select_option() {
	echo -e "$primary\n$secondary\n$dual\n$mirror" | selection_window
}

# Switch monitor configuration based on selection
chosen="$(select_option)"
case ${chosen} in
	$primary)
		${SCRIPTS_DIR}monitor.sh primary
		;;
	$secondary)
		${SCRIPTS_DIR}monitor.sh secondary
		;;
	$dual)
		${SCRIPTS_DIR}monitor.sh dual
		;;
	$mirror)
		${SCRIPTS_DIR}monitor.sh mirror
		;;
	*)
		exit 0
		;;
esac
