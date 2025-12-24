#!/bin/bash

# * Harden the system by installing at least one malware scanner, to perform periodic file system scans [HRDN-7230] 
# - Solution : Install a tool like rkhunter, chkrootkit, OSSEC, Wazuh
# - Related resources
#     * Article: Antivirus for Linux: is it really needed?: https://linux-audit.com/malware/antivirus-for-linux-really-needed/
#     * Article: Monitoring Linux Systems for Rootkits: https://linux-audit.com/monitoring-linux-systems-for-rootkits/
#     * Website: https://cisofy.com/lynis/controls/HRDN-7230/

read -p "This script will install 'rkhunter', a package used for rootkit detection. Continue? (Y/n) " answer
answer=${answer:-Y}  # Default to Y if empty

if [[ $answer =~ ^[Yy]$ ]]; then
    echo "Proceeding..."
    # Installing rkhunter
    sudo apt install -y rkhunter

    read -p "This line will run 'rkhunter' to check for rootkits. Continue? (Y/n) " answer
    answer=${answer:-Y}  # Default to Y if empty

    if [[ $answer =~ ^[Yy]$ ]]; then
        echo "Proceeding..."
        sudo rkhunter --check
    else
        echo "Aborted."
        exit 1
    fi
else
    echo "Aborted."
    exit 1
fi
