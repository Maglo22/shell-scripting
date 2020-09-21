#!/bin/bash -xe

# Script that exits on error and displays commands
# as they are executed, including all expansions and substitutions.
# Use 3 ls commands in your script.
# Make the first one succeed, the second one fail, and the third one succeed.
# The third ls command should not be executed.

ls /home
ls hellothere
ls .