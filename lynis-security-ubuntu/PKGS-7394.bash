#!/bin/bash

# * Install package apt-show-versions for patch management purposes [PKGS-7394] 
# - Related resources
#     * Website: https://cisofy.com/lynis/controls/PKGS-7394/

read -p "This script will install 'apt-show-versions' which is a tool to show package versions. Continue? (Y/n) " answer
answer=${answer:-Y}  # Default to Y if empty

if [[ $answer =~ ^[Yy]$ ]]; then
    echo "Proceeding..."
    sudo apt install apt-show-versions
    echo "'apt-show-versions' has been installed."
else
    echo "Aborted."
    exit 1
fi
