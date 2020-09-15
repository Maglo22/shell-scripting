#!/bin/bash

# Modify the previous script so that it accepts the file or
# directory name as an argument instead of prompting the user to enter it. 

[ $# -le 0 ] && echo "Usage: exercise-07.sh path-to-file" && exit
[ $1 ] && FD=$1

if [ -e $FD ]
then
    [ -d $FD ] && echo "$FD is a directory"
    [ -f $FD ] && echo "$FD is a regular file"
    ls $FD
else
    echo "$FD does not exist"
fi