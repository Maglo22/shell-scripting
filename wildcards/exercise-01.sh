#!/bin/bash

# Script that renames all files in the current directory that end in ".jpg"
# to begin with today's date in the following format: YYYY-­MM­-DD.

# handle error when there are no jpg files
shopt -s nullglob

DATE=$(date +%F)

for FILE in *.jpg
do
    echo "Renaming $FILE to $DATE-$FILE"
    mv $FILE $DATE-$FILE
done