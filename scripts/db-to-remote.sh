#!/bin/bash

function db-to-remote {

    # ALERT
    read -p "You are about to erase a broduction database. Are you really really reallllly sure you wanna do that, bro? (y/n)" choice
    case "$choice" in
      y|Y ) echo "Ok, bro.";;
      n|N ) die "Aborted by user.";;
      bro ) fortune;;
      * ) die "Abort: invalid answer.";;
    esac

    # DUMP DB LOCAL
    backup-local

    # DUMP DB PROD (just in case)
    backup-remote

    # COPY DB LOCAL TO REMOTE
    scp -P ${SSH_PORT} ${BACKUP_FOLDER}${DBLOCAL_DUMP_FILENAME} ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:

    # IMPORT DB LOCAL TO REMOTE
    IMPORT_COMMAND="${MYSQL_REMOTE_COMMAND} < ${DBLOCAL_DUMP_FILENAME}"
    ssh -p ${SSH_PORT} ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} ${IMPORT_COMMAND}

    # CMS SPECIFICS
    if [[ ${USED_CMS} == 'magento' ]]; then
        echo "Congratulations, what a beautiful Magento!"
        magento-db-specifics 'remote'
        clear-magento-cache
    elif [[ ${USED_CMS} == 'drupal' ]]; then
        clear-drupal-cache
        echo 'Drupal is cool. Nothing more to do.'
    elif [[ ${USED_CMS} == 'wordpress' ]]; then
        wordpress-db-specifics 'remote'
    fi
}
