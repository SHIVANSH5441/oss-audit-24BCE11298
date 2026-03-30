#!/bin/bash
# Script 4: Log File Analyzer
# Author: Shivansh Saraswat | Course: Open Source Software
# Purpose: Reads a log file line by line, counts lines containing a
#          keyword (default: "error"), prints a summary, and shows
#          the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh /path/to/logfile [keyword]

# --- Accept command-line arguments ---------------------------------------
# $1 is the first argument (log file path)
# $2 is the second argument (keyword) - defaults to "error" if not provided
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword is 'error' if none given

# --- Counter variable to track keyword matches ---------------------------
COUNT=0

echo "   Log File Analyzer"
echo ""

# --- Validate that a file argument was provided --------------------------
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo ""
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo "  Example: $0 /var/log/auth.log Failed"
    echo ""

    # If running on Kali/Debian, suggest a real log file to use
    echo "  Tip: Try one of these log files on your system:"
    for SUGGESTION in "/var/log/syslog" "/var/log/auth.log" "/var/log/kern.log" "/var/log/dpkg.log"; do
        if [ -f "$SUGGESTION" ]; then
            echo "       $SUGGESTION  (exists)"
        fi
    done
    echo ""
    exit 1
fi

# --- Check if the file exists and is readable ----------------------------
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Please provide a valid path to a log file."
    echo ""
    exit 1
fi

# --- Check if the file is empty ------------------------------------------
# -s returns true if file exists and has size greater than zero
RETRY=0
while [ ! -s "$LOGFILE" ] && [ $RETRY -lt 3 ]; do
    # do-while style retry loop if file appears empty
    echo "  WARNING: File appears to be empty. Waiting 1 second... (attempt $((RETRY+1))/3)"
    sleep 1
    RETRY=$((RETRY + 1))
done

if [ ! -s "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' is empty after 3 checks. Cannot analyse."
    exit 1
fi

# --- Display what we are about to analyse --------------------------------
TOTAL_LINES=$(wc -l < "$LOGFILE")
echo "  Log file  : $LOGFILE"
echo "  Keyword   : '$KEYWORD' (case-insensitive)"
echo "  Total lines in file: $TOTAL_LINES"
echo ""
echo "  Scanning..."
echo ""

# --- While-read loop: go through the log file line by line ---------------
# IFS= preserves leading/trailing whitespace in each line
# -r prevents backslash interpretation
while IFS= read -r LINE; do

    # If statement inside the loop: check if this line contains the keyword
    # grep -i = case-insensitive, -q = quiet (no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment counter for each match
    fi

done < "$LOGFILE"   # Feed the file into the while loop using redirection

# --- Print the summary ---------------------------------------------------
echo "  SUMMARY:"
echo "  Keyword '$KEYWORD' found $COUNT time(s) in $LOGFILE"

# Calculate percentage of lines that matched
if [ "$TOTAL_LINES" -gt 0 ]; then
    PERCENT=$(( (COUNT * 100) / TOTAL_LINES ))
    echo "  That is approximately $PERCENT% of all log lines."
fi

echo ""

# --- Show the last 5 lines that matched the keyword ----------------------
echo "  Last 5 matching lines:"
echo ""
# grep -i for case-insensitive, pipe to tail -5 to get last 5 matches
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -z "$MATCHES" ]; then
    echo "  (No matching lines found)"
else
    # Print each matching line with a ">" prefix for clarity
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  > $MATCH_LINE"
    done
fi

echo ""
echo "  End of Log File Analyzer"
