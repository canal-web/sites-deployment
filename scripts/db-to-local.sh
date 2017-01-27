#!/bin/bash

function db-to-local {

    # Create SQL dump
    backup-remote

    # Import database locally
    ${MYSQL_LOCAL_COMMAND} < ${BACKUP_FOLDER}${DBDUMP_FILENAME}

    if [[ ${USED_CMS} == 'magento' ]]; then
        echo "Congratulations, what a beautiful Magento!"
        magento-db-specifics 'local'
    elif [[ ${USED_CMS} == 'drupal' ]]; then
        echo 'Drupal is cool. Nothing more to do.'
    elif [[ ${USED_CMS} == 'wordpress' ]]; then
        echo 'TODO'
    fi

    rm ${BACKUP_FOLDER}${DBDUMP_FILENAME}
}
