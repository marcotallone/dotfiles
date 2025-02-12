#!/bin/bash

# Emoji picker script

# Emoji configuration file
EMOJI_CONFIG=~/dotfiles/rofi/.config/rofi/config-emoji.rasi

# Call rofi with emoji options
rofi -modi emoji -show emoji -replace -config $EMOJI_CONFIG
