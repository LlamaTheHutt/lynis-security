#!/bin/bash

# * Access to CUPS configuration could be more strict. [PRNT-2307] 
# - Related resources
#     * Website: https://cisofy.com/lynis/controls/PRNT-2307/

# Interactive Script to Secure CUPS (Common UNIX Printing System)
# Addresses Lynis PRNT-2307 security warning

# Color codes for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Error: This script must be run as root (use sudo)${NC}"
    exit 1
fi

CUPS_DIR="/etc/cups"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d-%H%M%S)"

# Function to prompt for continuation
prompt_continue() {
    echo -e "${YELLOW}$1${NC}"
    read -p "Continue? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}Operation cancelled by user.${NC}"
        exit 0
    fi
    echo ""
}

# Function to prompt for choice
prompt_choice() {
    echo -e "${YELLOW}$1${NC}" >&2
    read -p "Your choice: " choice_input
    echo "" >&2
    echo "$choice_input"
}

# Introduction
clear
echo "=========================================="
echo "     CUPS Security Hardening Tool"
echo "=========================================="
echo ""
echo "This script addresses Lynis warning PRNT-2307:"
echo "  'Access to CUPS configuration could be more strict'"
echo ""
echo "WHAT IS CUPS?"
echo "  CUPS (Common UNIX Printing System) manages printers on Linux."
echo "  If you don't use printers, you may not need it."
echo ""
echo "THE SECURITY ISSUE:"
echo "  CUPS configuration files can contain sensitive information like:"
echo "  • Printer passwords"
echo "  • Network printer configurations"
echo "  • Admin credentials"
echo ""
echo "  If these files have overly permissive access rights, unauthorized"
echo "  users could read this sensitive information."
echo ""
echo "THIS SCRIPT WILL:"
echo "  1. Check if CUPS is installed and running"
echo "  2. Offer to disable CUPS (if you don't need it)"
echo "  3. OR secure CUPS configuration files (if you do need it)"
echo ""
prompt_continue "Ready to proceed?"

# Step 1: Check CUPS status
echo -e "${BLUE}=========================================="
echo "STEP 1: Analyzing CUPS Status"
echo -e "==========================================${NC}"
echo ""
echo "EXPLANATION: Let's check if CUPS is installed and whether"
echo "it's currently running on your system."
echo ""

# Check if CUPS is installed
if ! command -v cupsd &> /dev/null; then
    echo -e "${GREEN}✓ CUPS is not installed on this system.${NC}"
    echo ""
    echo "No action needed! Since CUPS isn't installed, there's no"
    echo "security risk related to CUPS configuration files."
    echo ""
    echo -e "${GREEN}You can safely ignore the Lynis PRNT-2307 warning.${NC}"
    exit 0
fi

echo -e "${CYAN}CUPS is installed. Checking service status...${NC}"
echo ""

# Check if CUPS is running
cups_active=false
if systemctl is-active --quiet cups; then
    cups_active=true
    echo -e "  ${YELLOW}●${NC} CUPS service: ${GREEN}ACTIVE (running)${NC}"
else
    echo -e "  ${RED}●${NC} CUPS service: INACTIVE (stopped)"
fi

if systemctl is-enabled --quiet cups 2>/dev/null; then
    echo -e "  ${YELLOW}●${NC} CUPS startup: ${GREEN}ENABLED${NC} (starts at boot)"
else
    echo -e "  ${RED}●${NC} CUPS startup: DISABLED (won't start at boot)"
fi

echo ""
echo "Current CUPS configuration file permissions:"
if [ -f "$CUPS_DIR/cupsd.conf" ]; then
    ls -lh "$CUPS_DIR/cupsd.conf" | awk '{print "  " $1, $3, $4, $9}'
    
    # Check if permissions are too open
    perms=$(stat -c %a "$CUPS_DIR/cupsd.conf")
    if [ "$perms" -gt 640 ]; then
        echo -e "  ${RED}⚠ WARNING: Permissions ($perms) are too permissive!${NC}"
        echo "  Recommended: 640 (owner: read/write, group: read, others: none)"
    else
        echo -e "  ${GREEN}✓ Permissions ($perms) look reasonable${NC}"
    fi
else
    echo -e "  ${RED}✗ cupsd.conf not found${NC}"
fi

echo ""
prompt_continue "Status check complete. Continue to next step?"

# Step 2: Ask user if they need CUPS
echo -e "${BLUE}=========================================="
echo "STEP 2: Do You Need CUPS?"
echo -e "==========================================${NC}"
echo ""
echo "EXPLANATION: If you don't use printers (local or network),"
echo "you can disable CUPS completely. This is the most secure option."
echo ""
echo "Choose an option:"
echo -e "  ${GREEN}[1]${NC} I don't use printers - DISABLE CUPS completely (most secure)"
echo -e "  ${YELLOW}[2]${NC} I use printers - SECURE CUPS configuration files"
echo -e "  ${RED}[3]${NC} Cancel and exit"
echo ""

choice=$(prompt_choice "Enter 1, 2, or 3:")

case $choice in
    1)
        # Disable CUPS
        echo -e "${BLUE}=========================================="
        echo "Disabling CUPS Completely"
        echo -e "==========================================${NC}"
        echo ""
        echo "EXPLANATION: We'll stop the CUPS service and prevent it from"
        echo "starting at boot. This removes the security risk entirely."
        echo ""
        echo "Actions to be performed:"
        echo "  1. Stop the CUPS service"
        echo "  2. Disable CUPS from starting at boot"
        echo "  3. Mask CUPS sockets to prevent activation"
        echo ""
        prompt_continue "Proceed with disabling CUPS?"
        
        echo "Stopping CUPS service..."
        systemctl stop cups 2>/dev/null
        echo -e "  ${GREEN}✓${NC} CUPS stopped"
        
        echo "Disabling CUPS from startup..."
        systemctl disable cups 2>/dev/null
        echo -e "  ${GREEN}✓${NC} CUPS disabled"
        
        echo "Masking CUPS sockets..."
        systemctl mask cups.socket cups.path 2>/dev/null
        echo -e "  ${GREEN}✓${NC} CUPS sockets masked"
        
        echo ""
        echo -e "${GREEN}✓ SUCCESS! CUPS has been completely disabled.${NC}"
        echo ""
        echo "What this means:"
        echo "  • CUPS will not run"
        echo "  • CUPS will not start at boot"
        echo "  • The security risk is eliminated"
        echo ""
        echo "To re-enable CUPS in the future:"
        echo "  ${CYAN}sudo systemctl unmask cups.socket cups.path${NC}"
        echo "  ${CYAN}sudo systemctl enable cups${NC}"
        echo "  ${CYAN}sudo systemctl start cups${NC}"
        echo ""
        ;;
        
    2)
        # Secure CUPS
        echo -e "${BLUE}=========================================="
        echo "Securing CUPS Configuration"
        echo -e "==========================================${NC}"
        echo ""
        echo "EXPLANATION: We'll set proper permissions on CUPS configuration"
        echo "files to restrict access to only the root user and the 'lp'"
        echo "(line printer) group."
        echo ""
        echo "TECHNICAL DETAILS:"
        echo "  • Mode 640 means: Owner(rw) Group(r) Others(none)"
        echo "  • Owner: root (system administrator)"
        echo "  • Group: lp (print system group)"
        echo "  • Others: no access (prevents unauthorized reading)"
        echo ""
        
        # Check if lp group exists
        if ! getent group lp > /dev/null; then
            echo -e "${YELLOW}⚠ WARNING: 'lp' group doesn't exist on this system.${NC}"
            echo "We'll use 'root' group instead."
            LP_GROUP="root"
        else
            LP_GROUP="lp"
        fi
        
        prompt_continue "Proceed with securing CUPS configuration?"
        
        # Backup existing configuration
        echo ""
        echo "Creating backups..."
        backup_count=0
        
        for conf_file in cupsd.conf printers.conf classes.conf subscriptions.conf; do
            if [ -f "$CUPS_DIR/$conf_file" ]; then
                cp "$CUPS_DIR/$conf_file" "$CUPS_DIR/$conf_file$BACKUP_SUFFIX"
                echo -e "  ${GREEN}✓${NC} Backed up: $conf_file"
                backup_count=$((backup_count + 1))
            fi
        done
        
        if [ $backup_count -eq 0 ]; then
            echo "  No configuration files found to backup."
        fi
        
        echo ""
        echo "Setting secure permissions..."
        echo ""
        
        # Secure the CUPS directory
        echo "1. Securing /etc/cups directory..."
        chmod 755 "$CUPS_DIR"
        chown root:$LP_GROUP "$CUPS_DIR"
        echo -e "   ${GREEN}✓${NC} Directory permissions: 755 (root:$LP_GROUP)"
        
        # Secure main configuration file
        echo ""
        echo "2. Securing cupsd.conf (main configuration)..."
        if [ -f "$CUPS_DIR/cupsd.conf" ]; then
            chmod 640 "$CUPS_DIR/cupsd.conf"
            chown root:$LP_GROUP "$CUPS_DIR/cupsd.conf"
            echo -e "   ${GREEN}✓${NC} cupsd.conf: 640 (root:$LP_GROUP)"
        else
            echo -e "   ${YELLOW}⚠${NC} cupsd.conf not found"
        fi
        
        # Secure other configuration files
        echo ""
        echo "3. Securing additional configuration files..."
        secured=0
        for conf_file in printers.conf classes.conf subscriptions.conf; do
            if [ -f "$CUPS_DIR/$conf_file" ]; then
                chmod 640 "$CUPS_DIR/$conf_file"
                chown root:$LP_GROUP "$CUPS_DIR/$conf_file"
                echo -e "   ${GREEN}✓${NC} $conf_file: 640 (root:$LP_GROUP)"
                secured=$((secured + 1))
            fi
        done
        
        if [ $secured -eq 0 ]; then
            echo "   No additional config files found (this is normal)."
        fi
        
        # Restart CUPS if it's running
        echo ""
        if [ "$cups_active" = true ]; then
            echo "4. Restarting CUPS to apply changes..."
            systemctl restart cups
            if systemctl is-active --quiet cups; then
                echo -e "   ${GREEN}✓${NC} CUPS restarted successfully"
            else
                echo -e "   ${RED}✗${NC} CUPS failed to restart. Check: sudo systemctl status cups"
            fi
        else
            echo "4. CUPS is not running, no restart needed."
        fi
        
        echo ""
        echo -e "${GREEN}✓ SUCCESS! CUPS configuration secured.${NC}"
        echo ""
        echo "Summary of changes:"
        echo "  • Configuration files now have restrictive permissions (640)"
        echo "  • Only root and $LP_GROUP group can access them"
        echo "  • Sensitive information is protected"
        echo "  • Backups saved with extension: $BACKUP_SUFFIX"
        echo ""
        ;;
        
    3)
        echo -e "${RED}Operation cancelled by user.${NC}"
        exit 0
        ;;
        
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        exit 1
        ;;
esac

# Final verification
echo -e "${BLUE}=========================================="
echo "FINAL VERIFICATION"
echo -e "==========================================${NC}"
echo ""
echo "Let's verify the security improvements..."
echo ""

if [ "$choice" = "1" ]; then
    # Verify CUPS is disabled
    if systemctl is-active --quiet cups; then
        echo -e "${RED}✗ CUPS is still running${NC}"
    else
        echo -e "${GREEN}✓ CUPS service is stopped${NC}"
    fi
    
    if systemctl is-enabled --quiet cups 2>/dev/null; then
        echo -e "${RED}✗ CUPS is still enabled at boot${NC}"
    else
        echo -e "${GREEN}✓ CUPS is disabled at boot${NC}"
    fi
else
    # Verify CUPS permissions
    if [ -f "$CUPS_DIR/cupsd.conf" ]; then
        perms=$(stat -c %a "$CUPS_DIR/cupsd.conf")
        owner=$(stat -c %U:%G "$CUPS_DIR/cupsd.conf")
        
        if [ "$perms" -le 640 ] && [[ "$owner" == "root:$LP_GROUP" ]]; then
            echo -e "${GREEN}✓ cupsd.conf permissions are secure ($perms $owner)${NC}"
        else
            echo -e "${YELLOW}⚠ cupsd.conf permissions: $perms $owner${NC}"
        fi
    fi
fi

echo ""
echo "Next steps:"
echo "  1. Run Lynis to verify the fix:"
echo "     ${GREEN}sudo lynis audit system${NC}"
echo ""
echo "  2. Look for PRNT-2307 - it should now show as resolved"
echo ""

if [ "$choice" = "2" ] && [ $backup_count -gt 0 ]; then
    echo "Backup information:"
    echo "  • Backup files saved in: $CUPS_DIR"
    echo "  • Backup extension: $BACKUP_SUFFIX"
    echo ""
fi

echo -e "${GREEN}Security hardening complete!${NC}"
echo ""