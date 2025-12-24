#!/bin/bash

#* Default umask in /etc/login.defs could be more strict like 027 [AUTH-9328] 
# - Related resources
#     * Article: Set default file permissions on Linux with umask: https://linux-audit.com/filesystems/file-permissions/set-default-file-permissions-with-umask/
#     * Website: https://cisofy.com/lynis/controls/AUTH-9328/

read -p "This script will modify the default umask in /etc/login.defs to 027, which sets more restrictive permissions for new files and directories. Continue? (Y/n) " answer
answer=${answer:-Y}  # Default to Y if empty

if [[ $answer =~ ^[Yy]$ ]]; then
    echo "Proceeding..."
    
    read -p "This line will backup /etc/login.defs before making changes. Continue? (Y/n) " answer
    answer=${answer:-Y}  # Default to Y if empty
    if [[ $answer =~ ^[Yy]$ ]]; then
        echo "Proceeding..."
        # Backup the original file
        sudo cp /etc/login.defs /etc/login.defs.bak
        echo "Backup of /etc/login.defs created at /etc/login.defs.bak."
    else
        echo "Aborted."
    fi

    # Modify the UMASK value to 027
    read -p "Use 027 or 077 for umask? Difference: 027 allows group read and execute permissions, while 077 restricts permissions to the owner only. Choose (027/077): " umask_choice
    umask_choice=${umask_choice:-027}  # Default to 027 if empty
    if [[ ! $umask_choice =~ ^(027|077)$ ]]; then
        echo "Invalid choice. Please choose either 027 or 077."
        exit 1
    fi
    sudo sed -i "s/^UMASK.*/UMASK\t$umask_choice/" /etc/login.defs
    echo "UMASK in /etc/login.defs has been set to $umask_choice."
else
    echo "Aborted."
    exit 1
fi
