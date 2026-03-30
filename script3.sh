#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Shivansh Saraswat | Course: Open Source Software
# Purpose: Loops through important Linux system directories and reports
#          their disk usage, permissions, owner, and group.
#          Also checks the Git config directory specifically.

echo "   Disk and Permission Auditor"
echo ""

# --- List of important directories to audit ------------------------------
# These are standard Linux filesystem locations every sysadmin should know
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/var" "/opt")

echo "  Directory Audit Report"
echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
printf " %-20s %-30s %-10s %-10s %s\n" "DIRECTORY" "PERMISSIONS / OWNER / GROUP" "SIZE"
echo ""

# --- For loop: iterate over each directory in the array ------------------
for DIR in "${DIRS[@]}"; do

    # Check if the directory actually exists before trying to inspect it
    if [ -d "$DIR" ]; then

        # ls -ld gives a long listing of the directory itself (not its contents)
        # awk extracts specific fields: $1=permissions, $3=owner, $4=group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives human-readable size; cut -f1 takes just the number
        # 2>/dev/null suppresses "permission denied" errors for protected dirs
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # If du returned nothing (permission denied entirely), show N/A
        if [ -z "$SIZE" ]; then
            SIZE="N/A"
        fi

        # printf formats the output in aligned columns
        printf " %-20s %-12s %-10s %-10s %s\n" "$DIR" "$PERMS" "$OWNER" "$GROUP" "$SIZE"

    else
        # Directory does not exist on this system
        printf " %-20s %s\n" "$DIR" "[does not exist on this system]"
    fi

done

# --- Special section: Check Git's config directory -----------------------
echo ""
echo "  Git-Specific Directory Check:"
echo ""

# Git stores its global config in the user's home directory as .gitconfig
GIT_CONFIG="$HOME/.gitconfig"

# Git system-wide config is typically at /etc/gitconfig
GIT_SYSTEM_CONFIG="/etc/gitconfig"

# Git binaries are in /usr/bin or /usr/lib/git-core
GIT_BIN="/usr/bin/git"
GIT_CORE="/usr/lib/git-core"

# Check each Git-related path
for GIT_PATH in "$GIT_SYSTEM_CONFIG" "$GIT_BIN" "$GIT_CORE"; do
    if [ -e "$GIT_PATH" ]; then
        # -e checks if path exists (file or directory)
        PERMS=$(ls -ld "$GIT_PATH" 2>/dev/null | awk '{print $1, $3, $4}')
        echo "  FOUND   : $GIT_PATH"
        echo "  Perms   : $PERMS"
        echo ""
    else
        echo "  NOT FOUND: $GIT_PATH"
        echo ""
    fi
done

# --- Explain why permissions matter --------------------------------------
echo "  Why permissions matter for security:"
echo ""
echo "  /etc        - world-readable, root-owned. Config files live here."
echo "  /var/log    - logs may contain sensitive info; often root-only."
echo "  /tmp        - world-writable (rwxrwxrwt); the sticky bit (t)"
echo "                prevents users from deleting each other's files."
echo "  /usr/bin    - binaries are owned by root; not writable by users."
echo "                This stops normal users from replacing system tools."
echo ""
echo "  End of Disk and Permission Auditor"
