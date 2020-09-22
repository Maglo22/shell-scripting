#!/bin/bash

# Script that accepts a file directory name as an argument.
# It reports if it is a regular file, a directory,
# or other type of file.
# If it is a regular file, exit with a 0 exit status.
# If it is a directory, exit with a 1 exit status.
# If it is some other type of file, exit with a 2 exit status.

read -p "Enter file/directory path: " FD

if [ -e $FD ]
then
    [ -f $FD ] && exit 0
    [ -d $FD ] && exit 1 || exit 2
else
    echo "$FD does not exist"
    exit 255
fi