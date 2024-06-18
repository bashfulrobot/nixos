#!/usr/bin/env bash

# Copy all icons from Brave Web Apps to the target directory

# I create the web app in brave temporarily to get all the icons at multiple sizes
# then I copy them to the target directory
# then remove the brave web app and define it in nix

if [ -z "$1" ]; then
    echo "Error: No target directory provided."
    echo "Usage: $0 target_directory"
    exit 1
fi

target_dir=$1
target_path="$HOME/dev/nix/nixos/modules/apps/$target_dir/icons/"

if [ ! -d "$target_path" ]; then
    mkdir -p $target_path
fi

# Get the only directory under Manifest Resources
dir=$(exa $HOME/.config/BraveSoftware/Brave-Browser/Default/Web\ Applications/Manifest\ Resources/ | tr -d '[:space:]')

# Copy all files from the Icons subdirectory to the target directory
cp $HOME/.config/BraveSoftware/Brave-Browser/Default/Web\ Applications/Manifest\ Resources/$dir/Icons/* $target_path