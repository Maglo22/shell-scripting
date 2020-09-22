#!/bin/bash

# Script that prompts the user for a name of a file or directory
# and reports if it is a regular file, a directory, or other type of file.
# Also perform an ls command against the file or directory with the long listing option. 

read -p "Enter file/directory path: " FD

if [ -e $FD ]
then
    [ -d $FD ] && echo "$FD is a directory"
    [ -f $FD ] && echo "$FD is a regular file"
    ls -l $FD
else
    echo "$FD does not exist"
fi