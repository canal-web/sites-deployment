#!/bin/bash

function db-to-local {

    # Create SQL dump
    backup-remote

    # Import database locally
    ${MYSQL_LOCAL_COMMAND} < ${BACKUP_FOLDER}${DBDUMP_FILENAME}

    if [[ ${USED_CMS} == 'magento' ]]; then
        echo "Congratulations, what a beautiful Magento!"
        magento-db-specifics 'local'
    fi

    rm ${BACKUP_FOLDER}${DBDUMP_FILENAME}
}
