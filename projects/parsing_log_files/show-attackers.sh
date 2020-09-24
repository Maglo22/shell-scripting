#!/bin/bash

# Displays the number of failed login attempts
# by IP address and location.

readonly LIMIT='10'
# print usage message
usage() {
    echo "Usage: ${0} FILE"
    exit 1
}

[[ "$#" -eq 0 ]] && usage

LOG_FILE="${1}"
[[ ! -e "${LOG_FILE}" ]] && echo "Cannot open file: ${1}" >&2 && exit 1

# display CSV header
echo 'Count,IP,Location'

# loop through IPs
# extract IP addresses from file, count number of occurences,
# sort them by most failed attempts (reverse order)
grep ${LOG_FILE} | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read COUNT IP
do
    # if number of failed attempts is greater than the limit
    if [[ "${COUNT}" -gt "${LIMIT}" ]]
    then
        # get location of IP address
        LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
        echo "${COUNT},${IP},${LOCATION}"
    fi
done

exit 0
