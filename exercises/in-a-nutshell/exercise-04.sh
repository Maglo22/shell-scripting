#!/bin/bash

# Script to see if the file "/etc/shadow" exists. If it does exist,
# display "Shadow passwords are enabled."
# Next, check to see if you can write to the file. If you can,
# display "You have permissions to edit /etc/shadow."
# If you cannot, display "You do NOT have permissions to edit /etc/shadow." 

SHADOW_FILE="/etc/shadow"

if [ -e $SHADOW_FILE ]
then
    echo "Shadow passwords are enabled"
    if [ -w $SHADOW_FILE ]
    then
        echo "You have permissions to edit ${SHADOW_FILE}."
    else
        echo "You do not have permissions to edit ${SHADOW_FILE}."
    fi
else
    echo "Shadow passwords disabled"
fi