#!/bin/bash
# =============================================================================
# Script 5: Open Source Manifesto Generator
# Author: Himanshu Singhmar | Reg No: 24BAI10255
# Course: Open Source Software | Unit: 5
# Description: Interactively asks the user 3 questions and generates a
#              personalised open-source philosophy statement, saved to a file.
# Concepts: read (user input), string concatenation, file writing with >,
#           date command, aliases (demonstrated via comment)
# =============================================================================

# --- Alias concept demonstration ---
# In a shell session, you might define:
#   alias manifesto='./script5_manifesto_generator.sh'
# This makes the script easier to run by typing just 'manifesto'
# Aliases are session-level shortcuts — they don't persist in scripts themselves.

# --- Display welcome banner ---
echo "=================================================================="
echo "       OPEN SOURCE MANIFESTO GENERATOR"
echo "       OSS Capstone — Himanshu Singhmar | 24BAI10255"
echo "=================================================================="
echo ""
echo "  You are about to generate your personal Open Source Manifesto."
echo "  Answer three questions honestly. Your manifesto will be saved"
echo "  to a text file that you can include in your project submission."
echo ""
echo "=================================================================="
echo ""

# --- Gather user inputs using 'read' with prompts ---
# -p flag displays the prompt string before waiting for input

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate inputs: ensure none are empty ---
# If any answer is blank, substitute a default value
if [ -z "$TOOL" ]; then
    TOOL="Linux"              # Default tool if user left it blank
fi
if [ -z "$FREEDOM" ]; then
    FREEDOM="choice"          # Default word for freedom
fi
if [ -z "$BUILD" ]; then
    BUILD="an open-source tool"   # Default build idea
fi

# --- Get current date and logged-in username for the manifesto ---
DATE=$(date '+%d %B %Y')
AUTHOR=$(whoami)

# --- Define the output filename using the current username ---
OUTPUT="manifesto_${AUTHOR}.txt"

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Compose the manifesto paragraph using string concatenation ---
# We use echo with >> to append each line to the output file
# The first echo uses > to create/overwrite the file cleanly

# Write the header to the file (> creates/overwrites)
echo "==================================================================" > "$OUTPUT"
echo "                   MY OPEN SOURCE MANIFESTO                       " >> "$OUTPUT"
echo "==================================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Author  : Himanshu Singhmar ($(whoami))" >> "$OUTPUT"
echo "  Reg No  : 24BAI10255" >> "$OUTPUT"
echo "  Date    : $DATE" >> "$OUTPUT"
echo "  Course  : Open Source Software — OSS Capstone Project" >> "$OUTPUT"
echo "  Software: Git" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "------------------------------------------------------------------" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Main manifesto paragraph — composed from user's answers ---
# String concatenation: each echo adds a line, building the full paragraph
echo "  I believe in the power of open source because every day I rely" >> "$OUTPUT"
echo "  on $TOOL — a tool that someone built and shared freely with the" >> "$OUTPUT"
echo "  world, asking nothing in return. That act of sharing is not just" >> "$OUTPUT"
echo "  generosity; it is a philosophy. To me, freedom means $FREEDOM —" >> "$OUTPUT"
echo "  and that is exactly what open source software gives every person" >> "$OUTPUT"
echo "  who uses it: the freedom to run, study, modify, and redistribute." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  The open source movement teaches us that knowledge grows when it" >> "$OUTPUT"
echo "  is shared, not hoarded. When Linus Torvalds released the Linux" >> "$OUTPUT"
echo "  kernel, or when Git was made open, they did not lose anything —" >> "$OUTPUT"
echo "  the world gained everything. This is why I commit to carrying" >> "$OUTPUT"
echo "  that spirit forward. One day, I intend to build $BUILD and" >> "$OUTPUT"
echo "  release it openly, so that someone I will never meet can stand" >> "$OUTPUT"
echo "  on my shoulders, just as I have stood on the shoulders of those" >> "$OUTPUT"
echo "  who came before me." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  Open source is not just a licensing model. It is a statement" >> "$OUTPUT"
echo "  about how we believe knowledge and tools should work in the world:" >> "$OUTPUT"
echo "  openly, collaboratively, and for the benefit of everyone." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "------------------------------------------------------------------" >> "$OUTPUT"
echo "  Signed: Himanshu Singhmar | $DATE" >> "$OUTPUT"
echo "  'Software is like sex: it is better when it is free.'" >> "$OUTPUT"
echo "                                              — Linus Torvalds" >> "$OUTPUT"
echo "==================================================================" >> "$OUTPUT"

# --- Confirm the file was saved and display it ---
echo "=================================================================="
echo "  Manifesto saved to: $OUTPUT"
echo "=================================================================="
echo ""

# --- Display the saved manifesto using cat ---
cat "$OUTPUT"

echo ""
echo "  You can now copy $OUTPUT into your project folder."
echo "=================================================================="
