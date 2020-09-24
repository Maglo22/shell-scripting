#!/bin/bash

# Script that executes a given command on multiple servers.

SERVER_FILE='/vagrant/servers'

# options for the ssh command
SSH_OPTIONS='-o ConnectTimeout=2'

usage() {
    echo "Usage: ${0} [-nsv] [-f FILE] COMMAND" >&2
    echo "  -f FILE  Use FILE for the list of servers. Default: /vagrant/servers." >&2
    echo "  -n       Dry run mode. Display the command that would have been executed and exit." >&2
    echo "  -s       Execute the command using sudo on the remote server." >&2
    echo "  -v       Verbose mode. Displays the server name before executing command." >&2
    exit 1
}

[[ "${UID}" -eq 0 ]] && echo 'Do not execute as root. Use the -s option instead.' >&2 && usage

# parse options
while getopts f:nsv OPTION
do
    case ${OPTION} in
        f) SERVER_FILE="${OPTARG}" ;;
        n) DRY_RUN='true' ;;
        s) SUDO='sudo' ;;
        v) VERBOSE='true' ;;
        ?) usage ;;
    esac
done

# remove options, leave args
shift "$(( OPTIND - 1))"

# at least a command is expected as an argument
[[ "${#}" -lt 1 ]] && usage

COMMAND="${@}"

[[ ! -e ${SERVER_FILE} ]] && echo "Cannot read the server file ${SERVER_FILE}." >&2 && exit 1

# default exit status
EXIT_STATUS='0'

for SERVER in $(cat ${SERVER_FILE})
do
    # ping -c 1 ${SERVER} &> /dev/null
    # [[ "${?}" -ne 0 ]] && echo "${SERVER} unreachable."

    [[ "${VERBOSE}" = 'true' ]] && echo "${SERVER}"

    SSH_COMMAND="ssh ${SSH_OPTIONS} ${SERVER} ${SUDO} ${COMMAND}"

    # dry run
    if [[ "${DRY_RUN}" = 'true' ]]
    then
        echo "Dry run: ${SSH_COMMAND}"
    else
        ${SSH_COMMAND}
        SSH_EXIT_STATUS="${?}"

        # capture non zero exit status
        [[ "${SSH_EXIT_STATUS}" -ne 0 ]] && EXIT_STATUS="${SSH_EXIT_STATUS}" && echo "Execution on ${SERVER} failed." >&2
    fi
done

exit ${EXIT_STATUS}