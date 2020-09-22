#!/bin/bash

# Script that renames files based on the file extension.
# The script should prompt the user for a file extension.
# Next, it should ask the user what prefix to prepend to the file name(s).
# By default the prefix should be the current date in YYYY-­MM-­DD format.
# So, if the user simply presses enter the date will be used.
# Otherwise, whatever the user entered will be used as the prefix.
# Next, it should display the original file name and the new name of the file.
# Finally, it should rename the file. 

# handle error when there are no jpg files
shopt -s nullglob

DATE=$(date +%F)

read -p "Enter file extension: " FILE_EXTENSION
read -p "Enter file prefix: " FILE_PREFIX

[ -z ${FILE_PREFIX} ] && FILE_PREFIX=$DATE

for FILE in *.$FILE_EXTENSION
do
    echo "Renaming $FILE to $FILE_PREFIX-$FILE"
    mv $FILE $FILE_PREFIX-$FILE
done