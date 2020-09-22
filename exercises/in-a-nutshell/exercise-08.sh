#!/bin/bash

# Modify the previous script to accept an unlimited number of files
# and directories as arguments.

[ $# -le 0 ] && echo "Usage: exercise-08.sh path-to-file-1 path-to-file-2 ... path-to-file-n" && exit

for FD in $@
do
    if [ -e $FD ]
    then
        echo $FD
        [ -d $FD ] && echo "is a directory"
        [ -f $FD ] && echo "is a regular file"
        ls $FD
    else
        echo "$FD does not exist"
    fi
done
