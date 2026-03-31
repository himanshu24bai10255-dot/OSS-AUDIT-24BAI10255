#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: Himanshu Singhmar | Reg No: 24BAI10255
# Course: Open Source Software | Unit: 2
# Description: Checks if a chosen open-source package is installed,
#              displays its version/license, and prints a philosophy note.
# Concepts: if-then-else, case statement, rpm/dpkg, pipe with grep
# =============================================================================

# --- Set the package name to inspect ---
# For Git (our chosen software), the package name is 'git'
PACKAGE="git"

echo "=============================================="
echo "   FOSS Package Inspector — $PACKAGE"
echo "=============================================="
echo ""

# --- Detect Package Manager ---
# Different Linux distros use different package managers (rpm vs dpkg)
# We detect which one is available on this system
if command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
elif command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
else
    PKG_MANAGER="none"   # Neither found — very unusual Linux system
fi

echo "  Package Manager Detected: $PKG_MANAGER"
echo ""

# --- Check if package is installed using the detected manager ---
INSTALLED=false

if [ "$PKG_MANAGER" = "rpm" ]; then
    # RPM-based check (Fedora, CentOS, RHEL, etc.)
    if rpm -q "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "  [OK] $PACKAGE IS INSTALLED on this system."
        echo ""
        echo "  Package Details:"
        echo "  ----------------"
        # Extract Version, License and Summary from RPM database
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary|URL'
    fi
elif [ "$PKG_MANAGER" = "dpkg" ]; then
    # dpkg-based check (Ubuntu, Debian, etc.)
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        INSTALLED=true
        echo "  [OK] $PACKAGE IS INSTALLED on this system."
        echo ""
        echo "  Package Details:"
        echo "  ----------------"
        # Show package info using dpkg (similar to rpm -qi)
        dpkg -l "$PACKAGE" | grep "^ii"
        # Try apt-cache for more details if available
        if command -v apt-cache &>/dev/null; then
            apt-cache show "$PACKAGE" 2>/dev/null | grep -E 'Version|Homepage|License|Description' | head -6
        fi
    fi
fi

# --- If not installed by either method, try 'which' command as fallback ---
if [ "$INSTALLED" = false ]; then
    if command -v "$PACKAGE" &>/dev/null; then
        INSTALLED=true
        echo "  [OK] $PACKAGE IS INSTALLED (found in PATH)."
        echo ""
        echo "  Version Info:"
        $PACKAGE --version 2>/dev/null | head -3   # Show version output
    else
        echo "  [!!] $PACKAGE is NOT installed on this system."
        echo ""
        echo "  To install on Ubuntu/Debian : sudo apt install $PACKAGE"
        echo "  To install on Fedora/RHEL   : sudo dnf install $PACKAGE"
    fi
fi

echo ""
echo "----------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "----------------------------------------------"
echo ""

# --- Case statement: Print philosophy note based on package name ---
# Each case reflects the unique story and significance of that software
case $PACKAGE in
    git)
        echo "  Git: Born from necessity when Linus Torvalds rejected"
        echo "  proprietary BitKeeper in 2005. Git embodies the open"
        echo "  source spirit — distributed, free, and community-owned."
        echo "  It now powers virtually all of modern software development."
        ;;
    httpd|apache2)
        echo "  Apache HTTP Server: The web server that made the open"
        echo "  internet possible. Powers 30%+ of all websites globally,"
        echo "  proving that community-built software can outperform"
        echo "  any proprietary alternative."
        ;;
    mysql|mariadb)
        echo "  MySQL/MariaDB: A dual-license story — GPL for the community,"
        echo "  commercial for enterprises. When Oracle acquired MySQL,"
        echo "  the community forked it into MariaDB. Freedom works."
        ;;
    vlc)
        echo "  VLC: Built by students at Ecole Centrale Paris who needed"
        echo "  a free tool to stream video. It grew into the world's"
        echo "  most universal media player — a testament to student"
        echo "  innovation and the power of open collaboration."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web."
        echo "  Born from Netscape's open-sourcing, it challenged IE's"
        echo "  monopoly and championed web standards for all."
        ;;
    python3|python)
        echo "  Python: A language shaped entirely by community consensus."
        echo "  Guido van Rossum's 'Benevolent Dictator For Life' model"
        echo "  proves that open governance can produce elegant, "
        echo "  universally loved software."
        ;;
    libreoffice)
        echo "  LibreOffice: The definitive example of community power."
        echo "  When Oracle neglected OpenOffice, the community forked it."
        echo "  A reminder that open source projects belong to the people."
        ;;
    *)
        echo "  $PACKAGE: Every open-source tool stands on the shoulders"
        echo "  of the free software movement — built openly, shared freely,"
        echo "  and improved collectively for the benefit of all humanity."
        ;;
esac

echo ""
echo "=============================================="
echo "  Audit complete for package: $PACKAGE"
echo "=============================================="
