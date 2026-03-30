#!/bin/bash
# Script 1: System Identity Report
# Author: Shivansh Saraswat | Course: Open Source Software
# Purpose: Displays a welcome screen with system information and
#          identifies the open-source license of the OS

# --- Variables -----------------------------------------------------------
# Fill in your name
STUDENT_NAME="Shivansh Saraswat"
# Chosen software for the audit
SOFTWARE_CHOICE="Git"

# --- Gather system information using command substitution ----------------
# Linux kernel version
KERNEL=$(uname -r)
# Currently logged-in user
USER_NAME=$(whoami)
# Home directory of current user
HOME_DIR=$(echo $HOME)
# Human-readable uptime
UPTIME=$(uptime -p)
# e.g. Monday, 15 January 2024
CURRENT_DATE=$(date '+%A, %d %B %Y')
# e.g. 14:32:07
CURRENT_TIME=$(date '+%H:%M:%S')
# Machine hostname
HOSTNAME=$(hostname)

# --- Get Linux distro name from os-release file --------------------------
# /etc/os-release contains distribution information on most Linux systems
if [ -f /etc/os-release ]; then
    DISTRO=$(grep '^PRETTY_NAME' /etc/os-release | cut -d '"' -f 2)
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Display the system identity report ----------------------------------
echo "    Open Source Software Audit - System Report"
echo ""
echo "  Student    : $STUDENT_NAME"
echo "  Software   : $SOFTWARE_CHOICE"
echo ""
echo "  SYSTEM INFORMATION"
echo "  Hostname     : $HOSTNAME"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  User         : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "  OPEN SOURCE LICENSE"

# --- Case statement to identify OS license -------------------------------
# Different distributions use different licenses - we check the distro name
case "$DISTRO" in
    *Kali*)
        echo "  This system runs Kali Linux."
        echo "  License: GPL v2 (GNU General Public License version 2)"
        echo "  The Linux kernel is free software - you can use, study,"
        echo "  modify, and distribute it under GPL v2 terms."
        ;;
    *Ubuntu*|*Debian*)
        echo "  This system runs $DISTRO."
        echo "  License: GPL v2 (Linux kernel) + various FOSS licenses"
        ;;
    *Fedora*|*CentOS*|*Red\ Hat*)
        echo "  This system runs $DISTRO."
        echo "  License: GPL v2 (Linux kernel) + GPL/LGPL packages"
        ;;
    *)
        echo "  This system runs: $DISTRO"
        echo "  License: GPL v2 (Linux kernel - standard for all distros)"
        ;;
esac

echo ""
echo "  Git (chosen software) is also licensed under GPL v2."
echo "  Source: https://git-scm.com"
echo ""
echo "  End of System Identity Report"
