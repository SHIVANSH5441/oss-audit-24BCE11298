#!/bin/bash
# Script 2: FOSS Package Inspector
# Author: Shivansh Saraswat | Course: Open Source Software
# Purpose: Checks if Git (or another FOSS package) is installed,
#          displays its version and details, and prints a philosophy
#          note about the software using a case statement

# --- Define the package to inspect ---------------------------------------
# Our chosen software for the audit
PACKAGE="git"

echo "        FOSS Package Inspector"
echo "--"
echo "  Checking package: $PACKAGE"
echo ""

# --- Check if the package is installed -----------------------------------
# We try dpkg first (Debian/Ubuntu/Kali), then rpm (Red Hat/Fedora)
# &>/dev/null sends all output to /dev/null - we only care about exit code

if dpkg -l "$PACKAGE" &>/dev/null; then
    # Package found via dpkg (Debian/Ubuntu)
    echo "  STATUS: $PACKAGE is INSTALLED on this system."
    echo ""
    echo "  Package Details (dpkg):"

    # Extract version, description using dpkg -l and filtering with grep + awk
    VERSION=$(dpkg -l "$PACKAGE" | grep "^ii" | awk '{print $3}')
    DESCRIPTION=$(dpkg -l "$PACKAGE" | grep "^ii" | awk '{for(i=5;i<=NF;i++) printf $i " "; print ""}')

    echo "  Name        : $PACKAGE"
    echo "  Version     : $VERSION"
    echo "  Description : $DESCRIPTION"

elif rpm -q "$PACKAGE" &>/dev/null; then
    # Package found via rpm (Fedora/CentOS/Red Hat)
    echo "  STATUS: $PACKAGE is INSTALLED on this system."
    echo ""
    echo "  Package Details (rpm):"
    # rpm -qi gives detailed info; we pipe and grep for specific fields
    rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary|URL'

else
    # Package not found by either package manager
    echo "  STATUS: $PACKAGE is NOT installed on this system."
    echo ""
    echo "  To install it, run:"
    echo "      sudo apt install $PACKAGE    (on Kali/Debian/Ubuntu)"
    echo "      sudo dnf install $PACKAGE    (on Fedora/CentOS)"
    echo ""
    echo "  Installing now would require sudo privileges."
fi

# --- Show the currently installed Git version directly -------------------
echo ""
echo "  Direct version check:"

# git --version gives a clean version string regardless of package manager
if command -v git &>/dev/null; then
    GIT_VERSION=$(git --version)
    GIT_PATH=$(which git)
    echo "  $GIT_VERSION"
    echo "  Binary location: $GIT_PATH"
else
    echo "  git command not found in PATH"
fi

# --- Case statement: philosophy note per package name --------------------
# This demonstrates the case statement concept from the course
echo ""
echo "--"
echo "  Open Source Philosophy Note:"
echo ""

case $PACKAGE in
    git)
        echo "  Git: Born from frustration when Linus Torvalds lost access to"
        echo "  BitKeeper in 2005. He built Git in two weeks and gave it away"
        echo "  under GPL v2. Today it is the world's most used version control"
        echo "  system - proof that open source can outperform proprietary tools."
        ;;
    apache2|httpd)
        echo "  Apache: The web server that built the open internet."
        echo "  Powers hundreds of millions of websites under Apache License 2.0."
        ;;
    mysql)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  A rare dual-license story - GPL v2 and a commercial option."
        ;;
    vlc)
        echo "  VLC: Built by students at a Paris university to stream campus"
        echo "  video. Now the world's most versatile media player, LGPL/GPL."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web."
        echo "  Mozilla's answer to corporate browser dominance - MPL 2.0."
        ;;
    python3|python)
        echo "  Python: A language shaped entirely by its community."
        echo "  The PSF license is one of the most permissive in open source."
        ;;
    *)
        echo "  $PACKAGE: Part of the vast open source ecosystem that powers"
        echo "  modern computing - free to use, study, modify, and share."
        ;;
esac

echo ""
echo "  End of Package Inspector"
