#!/bin/bash

# Modify the previous script so that it uses a logging function.
# Additionally tag each syslog message with "randomly" and include the process ID.
# Generate 3 random numbers. 

logging() {
    local MSG=$@
    echo "$MSG"
    logger -i -t randomly -p user.info "$MSG"
}

logging $RANDOM
logging $RANDOM
logging $RANDOM