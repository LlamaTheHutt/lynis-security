#!/bin/bash

# * Install apt-listbugs to display a list of critical bugs prior to each APT installation. [DEB-0810] 
#     https://cisofy.com/lynis/controls/DEB-0810/

read -p "This script will install apt-listbugs to help identify critical bugs before package installations. Continue? (Y/n) " answer
answer=${answer:-Y}  # Default to Y if empty
if [[ $answer =~ ^[Yy]$ ]]; then
    echo "Proceeding..."
    
    # Update package lists
    sudo apt-get update

    # Install apt-listbugs
    sudo apt-get install -y apt-listbugs

    echo "apt-listbugs has been installed."
else
    echo "Aborted."
    exit 1
fi