#!/bin/bash

# Script that asks the user for the number of lines they would like
# to display from the /etc/passwd file.

FILE="/etc/passwd"
LINE_NUM=1

read -p "How many lines of ${FILE} would you like to see? " NUM_LINES
while [ $LINE_NUM -le $NUM_LINES ]
do
    read LINE
    echo "${LINE_NUM}: ${LINE}"
    ((LINE_NUM++))
done < $FILE