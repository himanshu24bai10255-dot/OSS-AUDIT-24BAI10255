#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: Himanshu Singhmar | Reg No: 24BAI10255
# Course: Open Source Software | Unit: 2
# Description: Loops through key Linux system directories and reports
#              disk usage, ownership, and permissions for each.
#              Also checks Git's config directory specifically.
# Concepts: for loop, arrays, df, ls -ld, du, awk, cut
# =============================================================================

# --- List of important system directories to audit ---
# These directories are standard across most Linux distributions
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/var/lib")

# --- Git-specific config directory (our chosen software) ---
GIT_CONFIG_DIR="/etc/gitconfig"     # System-wide git config file
GIT_BIN="/usr/bin/git"              # Git binary location

echo "=================================================================="
echo "       DISK AND PERMISSION AUDITOR — OSS Audit Report            "
echo "       Student: Himanshu Singhmar | Reg: 24BAI10255              "
echo "=================================================================="
echo ""
echo "  Date: $(date '+%d %B %Y %H:%M:%S')"
echo ""
echo "------------------------------------------------------------------"
echo "  SYSTEM DIRECTORY AUDIT"
echo "------------------------------------------------------------------"
printf "  %-20s %-30s %-10s\n" "Directory" "Permissions (perm owner group)" "Size"
printf "  %-20s %-30s %-10s\n" "---------" "------------------------------" "----"

# --- Loop through each directory in the array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Use ls -ld to get directory details, then awk to extract fields:
        # Field 1 = permissions, Field 3 = owner, Field 4 = group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # Use du -sh to get human-readable size of directory
        # 2>/dev/null suppresses permission errors for protected dirs
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # If size could not be determined, mark as restricted
        if [ -z "$SIZE" ]; then
            SIZE="N/A"
        fi

        # Print formatted row for this directory
        printf "  %-20s %-30s %-10s\n" "$DIR" "$PERMS" "$SIZE"
    else
        # Directory does not exist on this system
        printf "  %-20s %-30s\n" "$DIR" "[NOT FOUND on this system]"
    fi
done

echo ""
echo "------------------------------------------------------------------"
echo "  DISK USAGE OVERVIEW (Top-level partitions)"
echo "------------------------------------------------------------------"
# df shows filesystem disk usage; -h = human readable; --output selects columns
df -h --output=target,size,used,avail,pcent 2>/dev/null | grep -v "tmpfs\|udev\|overlay" | head -8

echo ""
echo "------------------------------------------------------------------"
echo "  GIT (Chosen Software) — Configuration & Binary Audit"
echo "------------------------------------------------------------------"

# --- Check Git binary location and permissions ---
if [ -f "$GIT_BIN" ]; then
    GIT_PERMS=$(ls -l "$GIT_BIN" | awk '{print $1, $3, $4}')
    echo "  Git Binary   : $GIT_BIN"
    echo "  Permissions  : $GIT_PERMS"
    echo "  Git Version  : $(git --version 2>/dev/null)"
else
    echo "  Git binary not found at $GIT_BIN"
    # Try finding git using 'which' command as fallback
    GIT_PATH=$(which git 2>/dev/null)
    if [ -n "$GIT_PATH" ]; then
        echo "  Found at     : $GIT_PATH"
        echo "  Permissions  : $(ls -l $GIT_PATH | awk '{print $1, $3, $4}')"
    else
        echo "  Git does not appear to be installed."
    fi
fi

echo ""

# --- Check system-wide Git config file ---
if [ -f "$GIT_CONFIG_DIR" ]; then
    GIT_CFG_PERMS=$(ls -l "$GIT_CONFIG_DIR" | awk '{print $1, $3, $4}')
    echo "  Git Config   : $GIT_CONFIG_DIR"
    echo "  Permissions  : $GIT_CFG_PERMS"
    echo ""
    echo "  Config Contents:"
    echo "  ----------------"
    cat "$GIT_CONFIG_DIR"      # Display the git config file contents
else
    echo "  System Git Config: Not found at $GIT_CONFIG_DIR"
    echo "  (This is normal — system-wide gitconfig is optional)"
fi

# --- Check user-level git config ---
USER_GIT_CONFIG="$HOME/.gitconfig"
if [ -f "$USER_GIT_CONFIG" ]; then
    echo ""
    echo "  User Git Config  : $USER_GIT_CONFIG"
    UCFG_PERMS=$(ls -l "$USER_GIT_CONFIG" | awk '{print $1, $3, $4}')
    echo "  Permissions      : $UCFG_PERMS"
fi

echo ""
echo "=================================================================="
echo "  Audit Complete — All directories and Git footprint documented."
echo "=================================================================="
