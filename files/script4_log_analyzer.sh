#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: Himanshu Singhmar | Reg No: 24BAI10255
# Course: Open Source Software | Units: 2 & 5
# Description: Reads a log file line by line, counts occurrences of a keyword,
#              and prints a detailed summary including the last 5 matching lines.
#              Supports command-line arguments for log file and keyword.
# Usage: ./script4_log_analyzer.sh /var/log/syslog [keyword]
# Concepts: while read loop, if-then, counter variables, $1/$2 arguments,
#           grep, tail, command-line input validation
# =============================================================================

# --- Accept command-line arguments ---
# $1 = path to log file (required)
# $2 = keyword to search for (optional, defaults to 'error')
LOGFILE=$1
KEYWORD=${2:-"error"}      # Default search keyword is 'error' if not provided

# --- Counter Variables ---
COUNT=0            # Counts matching lines
TOTAL_LINES=0      # Counts total lines in file
RETRY_COUNT=0      # Retry counter for empty file check
MAX_RETRIES=3      # Maximum retries before giving up

echo "=================================================================="
echo "       LOG FILE ANALYZER — OSS Audit Tool"
echo "       Student: Himanshu Singhmar | Reg: 24BAI10255"
echo "=================================================================="
echo ""

# --- Validate: Check if a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  [ERROR] No log file specified."
    echo ""
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo "  Example: $0 /var/log/auth.log WARNING"
    echo ""
    # Suggest available log files on the system
    echo "  Available log files on this system:"
    ls /var/log/*.log 2>/dev/null | head -5   # List .log files if they exist
    ls /var/log/syslog 2>/dev/null            # Check syslog specifically
    exit 1
fi

# --- Validate: Check if the file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  [ERROR] File not found: $LOGFILE"
    echo "  Please check the path and try again."
    exit 1
fi

# --- Do-while style retry loop: Check if file is empty ---
# We retry up to MAX_RETRIES times with a short pause each time
while [ "$RETRY_COUNT" -lt "$MAX_RETRIES" ]; do
    if [ -s "$LOGFILE" ]; then
        # File has content — break out of retry loop
        break
    else
        # File is empty — increment counter and wait
        RETRY_COUNT=$((RETRY_COUNT + 1))
        echo "  [WARN] Log file appears empty. Retry $RETRY_COUNT of $MAX_RETRIES..."
        sleep 1   # Wait 1 second before retrying (log may still be writing)
    fi
done

# --- If still empty after all retries, exit with message ---
if [ ! -s "$LOGFILE" ]; then
    echo "  [ERROR] Log file is empty after $MAX_RETRIES retries: $LOGFILE"
    exit 1
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "  Searched : $(date '+%d %B %Y %H:%M:%S')"
echo ""
echo "------------------------------------------------------------------"
echo "  SCANNING LOG FILE..."
echo "------------------------------------------------------------------"

# --- Main: Read log file line by line using while-read loop ---
# IFS= prevents trimming of leading/trailing whitespace
# -r flag prevents backslash escapes from being interpreted
while IFS= read -r LINE; do
    TOTAL_LINES=$((TOTAL_LINES + 1))     # Increment total line counter

    # --- Inner if-then: Check if current line contains the keyword ---
    # grep -i = case-insensitive, -q = quiet (no output, just return code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))             # Increment match counter
    fi

done < "$LOGFILE"     # Feed the log file as input to the while loop

echo ""
echo "------------------------------------------------------------------"
echo "  ANALYSIS SUMMARY"
echo "------------------------------------------------------------------"
echo ""
echo "  Total lines in file    : $TOTAL_LINES"
echo "  Keyword '$KEYWORD' found : $COUNT times"

# --- Calculate match percentage ---
if [ "$TOTAL_LINES" -gt 0 ]; then
    # Use awk for floating point division (bash only does integers)
    PERCENT=$(awk "BEGIN {printf \"%.2f\", ($COUNT / $TOTAL_LINES) * 100}")
    echo "  Match percentage       : $PERCENT%"
fi

echo ""

# --- Show last 5 matching lines using grep + tail ---
if [ "$COUNT" -gt 0 ]; then
    echo "------------------------------------------------------------------"
    echo "  LAST 5 MATCHING LINES (containing '$KEYWORD')"
    echo "------------------------------------------------------------------"
    echo ""
    # grep -i = case-insensitive match, then pipe to tail to get last 5
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
    echo ""
else
    echo "  No lines matching '$KEYWORD' were found in $LOGFILE."
    echo "  Try a different keyword such as: error, warning, fail, denied"
fi

echo "------------------------------------------------------------------"
echo "  Tip: Run with a different keyword — e.g.:"
echo "  $0 $LOGFILE WARNING"
echo "  $0 $LOGFILE failed"
echo "=================================================================="
echo "  Log analysis complete."
echo "=================================================================="
