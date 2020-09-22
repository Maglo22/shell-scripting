#!/bin/bash

# Startup script for sleepwalkingserver that accepts "start" and "stop" as arguments.
# If anything other than "start" or "stop" is provided as an argument,
# display a usage statement: "Usage sleep­walking start|stop"
# and terminate the script with an exit status of 1.

case "$1" in
    start)
        /tmp/sleepwalkingserver 
        ;;
    stop)
        kill $(cat /tmp/sleepwalkingserver.pid)
        ;;
    *)
        echo "Usage $0 start|stop" ; exit 1
        ;;
esac