#!/bin/bash

# Adds users to the same Linux system
# as the script is executed on.
# Expects an username and a real name as parameters.


# enforce root privileges
# send to stderr if fails (FD 2; >2)
[[ "$UID" -ne 0 ]] && echo "Script must be run as root" >&2 && exit 1

# print usage in case there are not enough parameters
[[ "$#" -lt 2 ]] && echo "Usage: $0 USER_NAME REAL_NAME" >&2 && exit 1

# details from parameters
USER_NAME=$1
shift 1 # remove $1 from positional parameters
PERSON_NAME=$@

# generate random password
PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c32)
SPECIAL_CHAR=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)

# creates account on local system
useradd -m ${USER_NAME} -c "${PERSON_NAME}"
[[ "${?}" -ne 0 ]] && echo "Error creating the account (${?})" >&2 && exit 1

# create password for new account
echo "${PASSWORD}${SPECIAL_CHAR}" | passwd --stdin ${USER_NAME} > /dev/null # discard stdout
[[ "${?}" -ne 0 ]] && echo "Error saving the password (${?})" >&2 && exit 1

# force password change on fisrt login
passwd -e ${USER_NAME} > /dev/null

# display username, password and host
echo 'User created (username | password | host):'
echo "${USER_NAME} | ${PASSWORD} | ${HOSTNAME}"

exit 0