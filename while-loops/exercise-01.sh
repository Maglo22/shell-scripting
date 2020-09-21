#!/bin/bash

# Script that loops through the /etc/passwd file one line at a time.
# Prepend each line with a line number followed by a colon and then a space.

FILE="/etc/passwd"
LINE_NUM=1

echo "content of $FILE"
while read LINE
do
    echo "${LINE_NUM}: ${LINE}"
    ((LINE_NUM++))
done < $FILE