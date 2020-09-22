#!/bin/bash

# Creates a new user account on the local system, based on user input,
# and prints information of the new user on screen.

# enforce root privileges
[[ "$UID" -ne 0 ]] && echo "Script must be run as root"  && exit 1

# prompt for account details
read -p 'Account username: ' USER_NAME
while [ -z $USER_NAME ]
do
    echo 'Please enter an username'
    read -p 'Account username: ' USER_NAME
done

read -p 'Name of the person using the account: ' PERSON_NAME
while [ -z "$PERSON_NAME" ]
do
    echo 'Please enter a name'
    read -p 'Name of the person using the account: ' PERSON_NAME
done

read -p 'Account password: ' PASSWORD
while [ -z $PASSWORD ]
do
    echo 'Please enter a password'
    read -p 'Account password: ' PASSWORD
done

# creates account on local system
useradd -m ${USER_NAME} -c "${PERSON_NAME}"
[[ "${?}" -ne 0 ]] && echo "Error creating the account (${?})" && exit 1

# create password for new account
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
[[ "${?}" -ne 0 ]] && echo "Error saving the password (${?})" && exit 1

# force password change on fisrt login
passwd -e ${USER_NAME}

# display username, password and host
echo 'User created:'
echo '(username | password | host)'
echo "${USER_NAME} | ${PASSWORD} | ${HOSTNAME}"

exit 0