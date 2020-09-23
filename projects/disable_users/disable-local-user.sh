#!/bin/bash

# Disables, deletes or archives a local user account

readonly ARCHIVE_DIR='/archive'

# prints usage message
usage() {
    echo "Usage: ${0} [-dra] USER [USERN]..."
    echo "Disable a local linux account."
    echo "  -d  Deletes accounts instead of disabling them."
    echo "  -r  Removes the home directory associated with the account(s)."
    echo "  -a  Creates an archive of the home directory associated with the account(s)."
    exit 1
}


# enforce root privileges | error displayed on stderr
[[ "$UID" -ne 0 ]] && echo "Script must be run as root" >&2 && exit 1

[[ "$#" -eq 0 ]] && usage

# Parse options
while getopts dra OPTION
do
    case ${OPTION} in
        d) DELETE_USER=true ;;
        r) REMOVE_OPTION='-r' ;;
        a) ARCHIVE=true ;;
        ?) usage ;;
    esac
done

# remove options and leave only the args
shift "$(( OPTIND - 1 ))"

for USER in "${@}"
do
    echo "Processing user: ${USER}"
    USERID=$(id -u $USER) || exit 1
    if [[ "${USERID}" -lt 1000 ]]
    then
        echo "User ${USER} has UID less than 1000, refusing to remove." >&2 && exit 1
    fi

    # archive user home dir (if requested)
    if [[ "${ARCHIVE}" = true ]]
    then
        # create archive directory if it doesnt exist
        [[ ! -d "${ARCHIVE_DIR}" ]] && mkdir -p ${ARCHIVE_DIR}
        [[ "${?}" -ne 0 ]] && echo "Could not create archive directory (${ARCHIVE_DIR})." >&2 && exit 1

        HOME_DIR="/home/${USER}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USER}.tgz"

        if [[ -d "${HOME_DIR}" ]]
        then
            echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
            tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
            [[ "${?}" -ne 0 ]] && echo "Could not create ${ARCHIVE_FILE}." >&2 && exit 1
        else
            echo "${HOME_DIR} does not exist or is not a directory." >&2 && exit 1
        fi
    fi

    # delete user
    if [[ "${DELETE_USER}" = true ]]
    then
        userdel ${REMOVE_OPTION} ${USER}
        [[ "${?}" -ne 0 ]] && echo "Error deleting account ${USER} (${?})." >&2 && exit 1
        echo "Account ${USER} deleted."
    # disable user
    else
        chage -E 0 ${USER}
        [[ "${?}" -ne 0 ]] && echo "Error disabling account ${USER} (${?})." >&2 && exit 1
        echo "Account ${USER} disabled."
    fi
done

exit 0