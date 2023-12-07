#!/usr/bin/env bash

# Copy SSH keys to ~/.ssh
cp id_* ~/.ssh/

# Set permissions for ~/.ssh
sudo chmod 0700 ~/.ssh

# Set permissions for files in ~/.ssh
sudo chmod 0600 ~/.ssh/id_*
