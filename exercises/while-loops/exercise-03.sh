#!/bin/bash

# Script that that allows a user to select an action from the menu.
# Available actions:
# - show the disk usage
# - show the uptime on the system
# - show the users that are logged into the system.
# Tell the user to enter q to quit. Display "Goodbye!" just before the script exits.
# If the user enters anything other than the options display "Invalid option"
 
while true
do
    echo "1: Show disk usage."
    echo "2: Show uptime."
    echo "3: Show users logged in."
    read -p "What would you like to do? (q to quit) " CHOICE
    case "$CHOICE" in
    1)
        df -h
        echo
        ;;
    2)
        uptime
        echo
        ;;
    3)
        who
        echo
        ;;
    q)
        echo "Goodbye!"
        break
        ;;
    *)
        echo "Invalid option"
        echo
        ;;
    esac
done