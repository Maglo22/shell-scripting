#!/bin/bash

# Modify the script from the previous exercise.
# Make the "file_count" function accept a directory as an argument.
# Next have the function display the name of the directory followed by a colon.
# Finally, display the number of files to the screen on the next line.
# Call the function with "/etc", "/var" and "/usr/bin"

# declare function
file_count() {
    local DIRECTORY=$1
    NUM_FILES=$(ls $DIRECTORY | wc -l)
    echo "${DIRECTORY}:"
    [ $NUM_FILES -gt 1 ] && echo "  $NUM_FILES files." || echo "  $NUM_FILES file."
}

# call function
file_count /etc
file_count /var
file_count /usr/bin