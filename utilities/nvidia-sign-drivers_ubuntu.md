# NVIDIA Driver Secure Boot Signing Script Documentation

## Overview

This bash script automates the process of signing NVIDIA kernel modules for use with Secure Boot on Ubuntu-based systems (including Linux Mint). Secure Boot requires all kernel modules to be cryptographically signed with a trusted key. Since NVIDIA's proprietary drivers aren't signed with keys trusted by default, this script creates and enrolls a Machine Owner Key (MOK) to sign them.

## Prerequisites

- Ubuntu/Linux Mint with NVIDIA drivers installed
- Root/sudo access
- Secure Boot currently disabled (will be enabled after setup)

## What the Script Does

### 1. Root Permission Check

```bash
if [ "$EUID" -ne 0 ]; then 
    echo "Error: This script must be run as root (use sudo)"
    exit 1
fi
```

**Purpose:** Ensures the script is run with root privileges, which are required for:
- Installing packages
- Accessing and modifying kernel modules
- Creating system-wide configuration files

---

### 2. Install Required Packages

```bash
apt-get update
apt-get install -y mokutil openssl
```

**Installs:**
- **mokutil**: Tool for managing Machine Owner Keys (MOK) in Secure Boot
- **openssl**: Cryptographic toolkit for generating keys and certificates

---

### 3. Create MOK Directory

```bash
MOK_DIR="/var/lib/shim-signed/mok"
mkdir -p "${MOK_DIR}"
chmod 700 "${MOK_DIR}"
```

**Purpose:** Creates a secure directory at `/var/lib/shim-signed/mok/` to store the signing keys. The directory is given restrictive permissions (700) so only root can access it.

---

### 4. Generate MOK Key Pair

```bash
openssl req -new -x509 -newkey rsa:2048 -keyout "${KEY_FILE}" -outform DER \
    -out "${CERT_FILE}" -nodes -days 36500 \
    -subj "/CN=NVIDIA Driver Signing Key/"
```

**Purpose:** Generates a self-signed X.509 certificate and private key pair if they don't already exist.

**Components:**
- **Private Key** (`MOK.priv`): Used to sign the kernel modules
- **Certificate** (`MOK.der`): Public key that will be enrolled in the system's MOK database
- **PEM Certificate** (`MOK.pem`): Alternative format for easier handling

**Parameters:**
- `rsa:2048`: Uses 2048-bit RSA encryption
- `-nodes`: No password protection on the private key
- `-days 36500`: Valid for ~100 years
- `-subj "/CN=NVIDIA Driver Signing Key/"`: Certificate subject name

---

### 5. Find and Sign NVIDIA Kernel Modules

```bash
KERNEL_VERSION=$(uname -r)
MODULE_DIR="/lib/modules/${KERNEL_VERSION}"
NVIDIA_MODULES=$(find "${MODULE_DIR}" -type f -name "nvidia*.ko*" 2>/dev/null)
```

**Purpose:** Locates all NVIDIA kernel modules (`.ko` files) in the current kernel's module directory and signs them.

**Process:**
1. Finds all files matching `nvidia*.ko*` pattern
2. Decompresses modules if they're compressed (`.ko.xz` or `.ko.zst`)
3. Signs each module using the kernel's `sign-file` script
4. Recompresses modules after signing

**Signing Command:**
```bash
/usr/src/linux-headers-${KERNEL_VERSION}/scripts/sign-file \
    sha256 "${KEY_FILE}" "${CERT_FILE}" "${module}"
```

This attaches a cryptographic signature to each module using SHA-256 hashing.

---

### 6. Create DKMS Signing Script

```bash
cat > /etc/dkms/sign-nvidia.sh << 'EOF'
#!/bin/bash
MOK_KEY="/var/lib/shim-signed/mok/MOK.priv"
MOK_CERT="/var/lib/shim-signed/mok/MOK.der"

for module in "$@"; do
    if [ -f "${module}" ]; then
        /usr/src/linux-headers-$(uname -r)/scripts/sign-file \
            sha256 "${MOK_KEY}" "${MOK_CERT}" "${module}"
    fi
done
EOF
```

**Purpose:** Creates a helper script that DKMS will use to automatically sign modules whenever they're rebuilt (during kernel updates or driver updates).

**DKMS (Dynamic Kernel Module Support):** Framework that automatically rebuilds kernel modules when you install a new kernel version.

---

### 7. Configure DKMS Framework

```bash
cat >> /etc/dkms/framework.conf << EOF
sign_tool="/etc/dkms/sign-nvidia.sh"
EOF
```

**Purpose:** Tells DKMS to use the signing script created in step 6 whenever it builds kernel modules. This ensures future NVIDIA driver updates are automatically signed without manual intervention.

---

### 8. Enroll MOK Key

```bash
mokutil --import "${CERT_FILE}"
```

**Purpose:** Schedules the MOK certificate for enrollment in the system's UEFI firmware. This requires a reboot to complete.

**What Happens:**
1. You create a one-time password during this step
2. On next reboot, before the OS loads, MOK Manager appears
3. You enter the password to confirm enrollment
4. The certificate is added to the firmware's trusted key database

---

## Post-Installation Process

### MOK Enrollment (On Reboot)

When you reboot, the system will display a blue MOK Manager screen:

1. **Select "Enroll MOK"** - Begin the enrollment process
2. **Select "Continue"** - Confirm you want to enroll
3. **Select "Yes"** - Final confirmation
4. **Enter Password** - The password you created when running the script
5. **Select "Reboot"** - Complete the enrollment

### Enable Secure Boot

After MOK enrollment is complete:
1. Reboot into BIOS/UEFI settings (usually F2, F10, F12, or Del during boot)
2. Navigate to Security or Boot settings
3. Enable Secure Boot
4. Save and exit

---

## How It Works: The Big Picture

### Why This Is Necessary

**Secure Boot** is a UEFI firmware security feature that prevents unauthorized code from running during the boot process. It does this by:
- Only allowing signed bootloaders and kernel modules to load
- Verifying signatures against keys stored in the UEFI firmware

**The Problem:** NVIDIA's proprietary drivers are kernel modules that aren't signed with keys trusted by default in your system's UEFI firmware.

**The Solution:** Create your own signing key (MOK), sign the NVIDIA modules with it, and enroll the key in your firmware so it's trusted.

### Trust Chain

```
UEFI Firmware
    ↓ (trusts)
MOK Certificate (your certificate)
    ↓ (verifies)
Signed NVIDIA Modules
    ↓ (loads)
Kernel
```

---

## Security Considerations

### Why MOK Is Safe

- The private key never leaves your system
- Only you have access to sign modules with your key
- The key is protected by root-only permissions
- You must physically authenticate at the MOK Manager to enroll the key

### What This Protects Against

- Rootkits that try to load unsigned kernel modules
- Malicious drivers attempting to run at kernel level
- Boot-time attacks on the kernel

### What This Doesn't Protect Against

- Attacks that occur after the kernel is loaded
- Vulnerabilities in properly signed code
- Physical attacks with direct hardware access

---

## File Locations

| File | Purpose | Location |
|------|---------|----------|
| Private Key | Signs modules | `/var/lib/shim-signed/mok/MOK.priv` |
| Certificate (DER) | Enrolled in MOK | `/var/lib/shim-signed/mok/MOK.der` |
| Certificate (PEM) | Alternative format | `/var/lib/shim-signed/mok/MOK.pem` |
| DKMS Signing Script | Auto-signs on updates | `/etc/dkms/sign-nvidia.sh` |
| DKMS Config | Configuration | `/etc/dkms/framework.conf` |
| Signed Modules | NVIDIA drivers | `/lib/modules/$(uname -r)/**/nvidia*.ko*` |

---

## Troubleshooting

### If Modules Don't Load After Enabling Secure Boot

1. Check if MOK was enrolled: `mokutil --list-enrolled`
2. Verify modules are signed: `modinfo nvidia | grep sig`
3. Re-run the script and try enrolling again

### If DKMS Doesn't Auto-Sign After Updates

1. Verify signing script exists: `ls -l /etc/dkms/sign-nvidia.sh`
2. Check DKMS config: `cat /etc/dkms/framework.conf`
3. Manually rebuild DKMS modules: `sudo dkms autoinstall`

### If MOK Manager Doesn't Appear on Reboot

1. Check if enrollment is pending: `mokutil --list-new`
2. Try enrolling again: `sudo mokutil --import /var/lib/shim-signed/mok/MOK.der`

---

## Maintenance

### After NVIDIA Driver Updates

The DKMS configuration ensures automatic signing. No manual action needed.

### After Kernel Updates

DKMS automatically rebuilds and signs modules for the new kernel.

### Checking Signature Status

```bash
# Check if a module is signed
modinfo nvidia | grep signature

# List enrolled MOKs
mokutil --list-enrolled
```

---

## Compatibility

This script works on:
- Ubuntu 20.04 LTS and newer
- Linux Mint 20 and newer
- Pop!_OS 20.04 and newer
- Other Ubuntu-based distributions with Secure Boot support

---

## Additional Resources

- [Ubuntu SecureBoot Documentation](https://wiki.ubuntu.com/UEFI/SecureBoot)
- [NVIDIA Driver Documentation](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
- [DKMS Manual](https://github.com/dell/dkms)
