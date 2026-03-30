#!/bin/bash
# Script 5: Open Source Manifesto Generator
# Author: Shivansh Saraswat | Course: Open Source Software
# Purpose: Asks the user three questions interactively, then composes
#          a personalised open source philosophy statement and saves
#          it to a .txt file using the date and user's name.

# --- Aliases concept (demonstrated via comment and function) -------------
# In bash, aliases let you create shortcuts for commands.
# Example: alias today='date +%d\ %B\ %Y'
# We demonstrate the concept below using a function instead
# (functions work in scripts; aliases are mainly for interactive shells)

greet() {
    echo "  Hello, $(whoami)! Let's write your open source manifesto."
}

# --- Display introduction ------------------------------------------------
echo "        Open Source Manifesto Generator"
echo ""
greet    # Call our greeting function
echo ""
echo "  Answer three questions and we will compose your"
echo "  personal open source philosophy statement."
echo ""
echo ""

# --- Read user input interactively ---------------------------------------
# read -p displays a prompt and waits for the user to type something
# The answer is stored in the variable on the right

read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""

read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""

read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validate that the user actually typed something ---------------------
# -z checks if a variable is empty (zero length)
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: Please answer all three questions."
    echo "  Run the script again and fill in each answer."
    exit 1
fi

# --- Get the current date using the date command -------------------------
DATE=$(date '+%d %B %Y')
TIME=$(date '+%H:%M')

# --- Build the output filename -------------------------------------------
# String concatenation: combine strings by placing them next to each other
OUTPUT="manifesto_$(whoami).txt"

# First clear the file if it already exists from a previous run
> "$OUTPUT"

# --- Write the header to the file ----------------------------------------
echo "=======================================================" >> "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Written by: $(whoami)" >> "$OUTPUT"
echo "  Date: $DATE at $TIME" >> "$OUTPUT"
echo "=======================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# --- Compose the manifesto paragraph -------------------------------------
# Using >> to append lines to a file (> would overwrite; >> adds to the end)
# We write each section separately and build the file piece by piece

# Write the main paragraph - using string concatenation with the three answers
echo "  I believe in the power of open source software. Every day," >> "$OUTPUT"
echo "  I rely on tools like $TOOL - software that exists not because" >> "$OUTPUT"
echo "  a company decided it was profitable, but because someone" >> "$OUTPUT"
echo "  chose to build it openly and share it with the world." >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "  To me, freedom in software means $FREEDOM. That is the kind" >> "$OUTPUT"
echo "  of freedom the GPL v2 license protects - the right to use," >> "$OUTPUT"
echo "  study, modify, and distribute software without restriction." >> "$OUTPUT"
echo "  This is not just a legal detail; it is a philosophy about" >> "$OUTPUT"
echo "  how knowledge should belong to everyone." >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "  If I could contribute something to the world, I would" >> "$OUTPUT"
echo "  build $BUILD and release it as open source. Because the" >> "$OUTPUT"
echo "  best ideas grow stronger when others can improve them." >> "$OUTPUT"
echo "  We all stand on the shoulders of giants - those who" >> "$OUTPUT"
echo "  wrote the code that our tools, careers, and futures run on." >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "  This audit has shown me that open source is not just about" >> "$OUTPUT"
echo "  free software. It is about trust, transparency, and community." >> "$OUTPUT"
echo "  Choosing $TOOL was not just a technical choice. It was a" >> "$OUTPUT"
echo "  statement: that good tools should be open to everyone." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "=======================================================" >> "$OUTPUT"

# --- Confirm the file was saved and display it ---------------------------
echo ""
echo "  Manifesto saved to: $OUTPUT"
echo ""

# cat reads and displays the file contents to the terminal
cat "$OUTPUT"

echo ""
echo "  You can find your manifesto at: $(pwd)/$OUTPUT"
