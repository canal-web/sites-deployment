#!/bin/bash

function db-to-remote {

    # ALERT
    read -p "You are about to erase a broduction database. Are you really really reallllly sure you wanna do that, bro? (y/n)" choice
    case "$choice" in
      y|Y ) echo "Ok, bro.";;
      n|N ) die;;
      bro ) fortune;;
      * ) echo "invalid";;
    esac

    # DUMP DB LOCAL
    backup-local

    # DUMP DB PROD (just in case)
    #backup-remote

    # COPY DB LOCAL TO REMOTE
    scp ${BACKUP_FOLDER}${DBDUMP_FILENAME} ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:

    # IMPORT DB LOCAL TO REMOTE
    IMPORT_COMMAND="${MYSQL_REMOTE_COMMAND} < ${DBDUMP_FILENAME}"
    ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} ${IMPORT_COMMAND}

    # MAGENTO SPECIFICS
    if [[ ${USED_CMS} == 'magento' ]]; then
        echo "Congratulations, what a beautiful Magento!"
        magento-db-specifics 'remote'
    fi
}
