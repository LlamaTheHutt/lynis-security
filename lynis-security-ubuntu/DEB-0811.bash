#!/bin/bash

# * Install apt-listchanges to display any significant changes prior to any upgrade via APT. [DEB-0811] 
#     https://cisofy.com/lynis/controls/DEB-0811/

read -p "This script will install apt-listchanges to help identify significant changes before package upgrades. Continue? (Y/n) " answer
answer=${answer:-Y}  # Default to Y if empty
if [[ $answer =~ ^[Yy]$ ]]; then
    echo "Proceeding..."

    # Update package lists
    sudo apt-get update

    # Install apt-listchanges
    sudo apt-get install -y apt-listchanges

    echo "apt-listchanges has been installed."
else
    echo "Aborted."
    exit 1
fi