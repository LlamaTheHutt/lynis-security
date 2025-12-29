#!/bin/bash

# NVIDIA Driver Signing Script for Secure Boot on Linux Mint 22.1
# This script sets up MOK (Machine Owner Key) signing for NVIDIA drivers

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Error: This script must be run as root (use sudo)${NC}"
    exit 1
fi

echo -e "${GREEN}=== NVIDIA Driver Signing Setup for Secure Boot ===${NC}\n"

# Variables
MOK_DIR="/var/lib/shim-signed/mok"
KEY_NAME="MOK"
KEY_FILE="${MOK_DIR}/${KEY_NAME}.priv"
CERT_FILE="${MOK_DIR}/${KEY_NAME}.der"
PEM_FILE="${MOK_DIR}/${KEY_NAME}.pem"

# Step 1: Install required packages
echo -e "${YELLOW}Step 1: Installing required packages...${NC}"
apt-get update
apt-get install -y mokutil openssl

# Step 2: Create MOK directory if it doesn't exist
echo -e "${YELLOW}Step 2: Creating MOK directory...${NC}"
mkdir -p "${MOK_DIR}"
chmod 700 "${MOK_DIR}"

# Step 3: Generate MOK key pair if it doesn't exist
if [ -f "${KEY_FILE}" ] && [ -f "${CERT_FILE}" ]; then
    echo -e "${GREEN}MOK keys already exist. Skipping key generation.${NC}"
else
    echo -e "${YELLOW}Step 3: Generating MOK key pair...${NC}"
    openssl req -new -x509 -newkey rsa:2048 -keyout "${KEY_FILE}" -outform DER \
        -out "${CERT_FILE}" -nodes -days 36500 \
        -subj "/CN=NVIDIA Driver Signing Key/"
    
    # Also create PEM version for easier handling
    openssl x509 -in "${CERT_FILE}" -inform DER -out "${PEM_FILE}"
    
    chmod 600 "${KEY_FILE}"
    chmod 644 "${CERT_FILE}" "${PEM_FILE}"
    echo -e "${GREEN}MOK key pair generated successfully.${NC}"
fi

# Step 4: Find and sign all NVIDIA kernel modules
echo -e "${YELLOW}Step 4: Finding and signing NVIDIA kernel modules...${NC}"

KERNEL_VERSION=$(uname -r)
MODULE_DIR="/lib/modules/${KERNEL_VERSION}"

# Find all NVIDIA modules
NVIDIA_MODULES=$(find "${MODULE_DIR}" -type f -name "nvidia*.ko*" 2>/dev/null)

if [ -z "${NVIDIA_MODULES}" ]; then
    echo -e "${RED}Warning: No NVIDIA kernel modules found!${NC}"
    echo "Make sure NVIDIA drivers are installed."
else
    for module in ${NVIDIA_MODULES}; do
        # Handle compressed modules
        if [[ "${module}" == *.ko.xz ]]; then
            echo "Decompressing and signing: ${module}"
            xz -d "${module}"
            module="${module%.xz}"
        elif [[ "${module}" == *.ko.zst ]]; then
            echo "Decompressing and signing: ${module}"
            zstd -d "${module}"
            module="${module%.zst}"
        fi
        
        if [[ "${module}" == *.ko ]]; then
            echo "Signing: ${module}"
            /usr/src/linux-headers-${KERNEL_VERSION}/scripts/sign-file \
                sha256 "${KEY_FILE}" "${CERT_FILE}" "${module}"
            
            # Recompress if needed
            if command -v xz &> /dev/null; then
                xz -f "${module}"
            fi
        fi
    done
    echo -e "${GREEN}All NVIDIA modules signed successfully.${NC}"
fi

# Step 5: Create signing script for DKMS
echo -e "${YELLOW}Step 5: Creating DKMS signing script...${NC}"

cat > /etc/dkms/sign-nvidia.sh << 'EOF'
#!/bin/bash
# DKMS signing script for NVIDIA modules

MOK_KEY="/var/lib/shim-signed/mok/MOK.priv"
MOK_CERT="/var/lib/shim-signed/mok/MOK.der"

for module in "$@"; do
    if [ -f "${module}" ]; then
        /usr/src/linux-headers-$(uname -r)/scripts/sign-file \
            sha256 "${MOK_KEY}" "${MOK_CERT}" "${module}"
    fi
done
EOF

chmod 700 /etc/dkms/sign-nvidia.sh

# Step 6: Configure DKMS to use the signing script
echo -e "${YELLOW}Step 6: Configuring DKMS...${NC}"

DKMS_CONF="/etc/dkms/framework.conf"

if ! grep -q "sign_tool=" "${DKMS_CONF}" 2>/dev/null; then
    cat >> "${DKMS_CONF}" << EOF

# Automatic module signing for Secure Boot
sign_tool="/etc/dkms/sign-nvidia.sh"
EOF
    echo -e "${GREEN}DKMS configured for automatic signing.${NC}"
else
    echo -e "${GREEN}DKMS already configured for signing.${NC}"
fi

# Step 7: Enroll the MOK key
echo -e "${YELLOW}Step 7: Enrolling MOK key...${NC}"
echo -e "${GREEN}You will be prompted to create a password.${NC}"
echo -e "${YELLOW}IMPORTANT: Remember this password! You'll need it on next reboot.${NC}\n"

mokutil --import "${CERT_FILE}"

echo -e "\n${GREEN}=== Setup Complete! ===${NC}\n"
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Reboot your system"
echo "2. During boot, you'll see a blue MOK Manager screen"
echo "3. Select 'Enroll MOK' -> 'Continue' -> 'Yes'"
echo "4. Enter the password you just created"
echo "5. Select 'Reboot'"
echo "6. Enable Secure Boot in your BIOS/UEFI settings"
echo ""
echo -e "${GREEN}After this, your NVIDIA drivers will work with Secure Boot enabled!${NC}"
echo -e "${YELLOW}Future driver updates will be automatically signed by DKMS.${NC}"