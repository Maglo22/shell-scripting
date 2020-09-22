#!/bin/bash

# Script that executes the command "cat /etc/shadow".
# If the command returns a 0 exit status report "Command succeeded"
# and exit with a 0 exit status.
# If the command returns a non­zero exit status report "Command failed"
# and exit with a 1 exit status.

cat /etc/shadow
[ $? -eq 0 ] && echo "Command succeeded" && exit 0 || echo "Command failed" ; exit 1