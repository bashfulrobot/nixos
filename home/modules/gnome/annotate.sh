#!/usr/bin/env bash

# Directory where screenshots are stored
dir="$HOME/Pictures/Screenshots"

# Get the most recent screenshot
recent_screenshot=$(/run/current-system/sw/bin/ls -t "$dir"/Screenshot\ from\ *.png | head -n1)

# Check if a file was found
if [[ -z "$recent_screenshot" ]]; then
    echo "No screenshot files found in $dir"
    exit 1
fi

# Load the screenshot into the satty tool
satty --filename "$recent_screenshot"
