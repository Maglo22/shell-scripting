#!/bin/bash

# Script that displays "man", "bear", "pig", "dog", "cat", and "sheep"
# to the screen with each appearing on a separate line.

THINGS="man bear pig dog cat sheep"

for THING in $THINGS
do
    echo $THING
done