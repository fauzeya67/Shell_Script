#!/bin/bash

# Welcome message
echo "Welcome to the Interactive File and Directory Explorer!"

# Part 1: File and Directory Exploration
# Loop until user decides to exit
while true; do
    echo
    echo "Files and Directories in the Current Path:"

    # Use ls to display files and directories in human-readable format (size in KB, MB, etc.)
    ls -lh --block-size=K | awk '{print "- "$9" ("$5")"}'

    echo
    # Part 2: Character Counting
    echo "Enter a line of text (Press Enter without text to exit):"
    read user_input

    # Exit the loop if the user presses Enter without entering any text
    if [ -z "$user_input" ]; then
        echo "Exiting the Interactive Explorer. Goodbye!"
        break
    fi

    # Count the number of characters in the user's input
    char_count=${#user_input}
    echo "Character Count: $char_count"
done

