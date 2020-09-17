#!/bin/bash

# Script that consists of a function that displays
# the number of files in the present working directory.

# declare function
file_count() {
    local DIRECTORY=$(pwd)
    NUM_FILES=$(ls $DIRECTORY | wc -l)
    [ $NUM_FILES -gt 1 ] echo "${DIRECTORY}: $NUM_FILES files." || echo "${DIRECTORY}: $NUM_FILES file."
}

# call function
file_count