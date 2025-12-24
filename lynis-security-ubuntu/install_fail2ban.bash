#!/bin/bash

read -p "This script will install 'fail2ban' which is a Daemon to ban hosts that cause multiple authentication errors. Continue? (Y/n) " answer
answer=${answer:-Y}  # Default to Y if empty

if [[ $answer =~ ^[Yy]$ ]]; then
    echo "Proceeding..."
    # Installing fail2ban
    sudo apt install -y fail2ban

    read -p "This line will enable and start the 'fail2ban' service. Continue? (Y/n) " answer
    answer=${answer:-Y}  # Default to Y if empty

    if [[ $answer =~ ^[Yy]$ ]]; then
        echo "Proceeding..."
        sudo systemctl enable fail2ban
        sudo systemctl start fail2ban
        echo "'fail2ban' service has been enabled and started."
    else
        echo "Aborted."
        exit 1
    fi
else
    echo "Aborted."
    exit 1
fi