#!/bin/bash

# Script that displays one random number to the screen
# and also generates a syslog message with that random number.
# Use the "user" facility and the "info" severity. 

R=$RANDOM

echo "$R"
logger -p user.info "$R"