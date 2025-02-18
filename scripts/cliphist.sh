#!/bin/bash

# Clipboard history script

# Cliphist configuration file
CLIPHIST_CONFIG=~/dotfiles/rofi/.config/rofi/config-cliphist.rasi

# Call rofi with cliphist options
case $1 in
		d) cliphist list | rofi -dmenu -replace -config $CLIPHIST_CONFIG | cliphist delete
			 ;;

		w) if [ `echo -e "Clear\nCancel" | rofi -dmenu -config ~/dotfiles/rofi/config-short.rasi` == "Clear" ] ; then
						cliphist wipe
			 fi
			 ;;

		*) cliphist list | rofi -dmenu -replace -config $CLIPHIST_CONFIG | cliphist decode | wl-copy
			 ;;
esac

