#!/bin/bash

SCRIPT_DIR="./lynis-security-ubuntu"

# Check if whiptail is installed
if ! command -v whiptail &> /dev/null; then
    echo "Error: whiptail is not installed."
    echo "Install with: sudo apt install whiptail"
    exit 1
fi

# Check if the directory exists
if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Error: Directory '$SCRIPT_DIR' not found!"
    exit 1
fi

# Find all .bash files in the directory
mapfile -t scripts < <(find "$SCRIPT_DIR" -maxdepth 1 -name "*.bash" -type f | sort)

# Check if any scripts were found
if [ ${#scripts[@]} -eq 0 ]; then
    echo "No .bash files found in $SCRIPT_DIR"
    exit 1
fi

# Main loop - keeps menu open
while true; do
    # Build menu items array
    menu_items=()
    for i in "${!scripts[@]}"; do
        script_name=$(basename "${scripts[$i]}")
        menu_items+=("$i" "$script_name")
    done

    # Show menu and get selection
    choice=$(whiptail --title "Harden Ubuntu! | Star me @llamathehutt" \
        --menu "Use arrow keys to navigate, Enter to select, Esc to exit. Once you select an option, the script will run with interactive prompts and descriptions." \
        20 60 10 \
        "${menu_items[@]}" \
        3>&1 1>&2 2>&3)

    # Check if user cancelled (pressed Esc)
    if [ $? -ne 0 ]; then
        clear
        echo "Exiting..."
        exit 0
    fi

    # Execute the selected script
    if [ -n "$choice" ]; then
        clear
        selected_script="${scripts[$choice]}"
        echo "Executing: $selected_script"
        echo "========================================"
        bash "$selected_script"
        echo "========================================"
        echo "Script completed. Press Enter to return to menu..."
        read -r
    fi
done