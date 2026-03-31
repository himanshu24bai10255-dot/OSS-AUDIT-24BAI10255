#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: Himanshu Singhmar | Reg No: 24BAI10255
# Course: Open Source Software | Unit: 1 & 2
# Description: Displays a welcome screen with system information and
#              open-source license details of the running OS.
# =============================================================================

# --- Student and Software Variables ---
STUDENT_NAME="Himanshu Singhmar"       # Student full name
REG_NO="24BAI10255"                    # Registration number
SOFTWARE_CHOICE="Git"                   # Chosen open-source software

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                     # Get Linux kernel version
USER_NAME=$(whoami)                    # Get current logged-in username
HOME_DIR=$HOME                         # Get home directory of current user
UPTIME=$(uptime -p)                    # Get human-readable system uptime
CURRENT_DATE=$(date '+%d %B %Y, %H:%M:%S')  # Get formatted current date and time

# --- Detect Linux Distribution name ---
# /etc/os-release is the standard file for distro info on modern Linux systems
if [ -f /etc/os-release ]; then
    DISTRO=$(grep -m 1 "^PRETTY_NAME" /etc/os-release | cut -d'=' -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"   # Fallback if file doesn't exist
fi

# --- Detect OS License ---
# Most Linux distributions are licensed under GPL v2 or GPL v3
# We check the distro name to assign the appropriate license message
case "$DISTRO" in
    *Ubuntu*|*Debian*)   OS_LICENSE="GNU GPL v2 / v3 (Linux Kernel) + Various FOSS Licenses" ;;
    *Fedora*|*Red\ Hat*) OS_LICENSE="GNU GPL v2 (Linux Kernel) + Red Hat EULA for enterprise" ;;
    *Arch*)              OS_LICENSE="GNU GPL v2 (Linux Kernel) + Mixed Open Source Licenses" ;;
    *)                   OS_LICENSE="GNU General Public License v2 (Linux Kernel)" ;;
esac

# --- Display the System Identity Report ---
echo "=================================================================="
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT              "
echo "=================================================================="
echo ""
echo "  Student    : $STUDENT_NAME"
echo "  Reg No     : $REG_NO"
echo "  Software   : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged User  : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $CURRENT_DATE"
echo ""
echo "------------------------------------------------------------------"
echo "  OS LICENSE"
echo "------------------------------------------------------------------"
echo "  $OS_LICENSE"
echo ""
echo "  The Linux kernel is free software: you can redistribute it"
echo "  and/or modify it under the terms of the GNU GPL as published"
echo "  by the Free Software Foundation, version 2."
echo "=================================================================="
echo ""
echo "  'Free software is a matter of liberty, not price.' — R. Stallman"
echo "=================================================================="
