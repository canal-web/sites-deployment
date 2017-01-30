#!/bin/bash

# Function to format current date (used in file naming)
DATE=$(date '+%Y%m%d')
BACKUP_FOLDER="${DIR}backups/"

# Create backups directory if not already present
mkdir ${BACKUP_FOLDER} -p

function backup-remote {

    # Settings
    SITENAME=${REMOTE_SQL_DATABASE}

    # Make a dump
    if [[ $1 == 'gz' ]]; then
        DBDUMP_FILENAME="${SITENAME}_remote_${DATE}.gz"
        DUMP_COMMAND="mysqldump -h${REMOTE_SQL_HOST} -u${REMOTE_SQL_USER} -p${REMOTE_SQL_PASSWORD} ${REMOTE_SQL_DATABASE} | gzip > ${DBDUMP_FILENAME}"
    else
        DBDUMP_FILENAME="${SITENAME}_remote_${DATE}.sql"
        DUMP_COMMAND="mysqldump -h${REMOTE_SQL_HOST} -u${REMOTE_SQL_USER} -p${REMOTE_SQL_PASSWORD} ${REMOTE_SQL_DATABASE} > ${DBDUMP_FILENAME}"
    fi
    ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} ${DUMP_COMMAND}

    # Copy it locally
    scp ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${DBDUMP_FILENAME} ${BACKUP_FOLDER}

    # Remove distant .sql file
    RM_COMMAND="rm -f ${DBDUMP_FILENAME}"
    ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} ${RM_COMMAND}

    # Return hey it's okay
    echo "New file in: "${BACKUP_FOLDER}${DBDUMP_FILENAME}
}

function backup-local {

    # Settings
    SITENAME=${LOCAL_SQL_DATABASE}

    # Make a dump
    DBDUMP_FILENAME="${SITENAME}_local_${DATE}.sql"
    mysqldump -h${LOCAL_SQL_HOST} -u${LOCAL_SQL_USER} -p${LOCAL_SQL_PASSWORD} ${LOCAL_SQL_DATABASE} > ${BACKUP_FOLDER}${DBDUMP_FILENAME}

    # Return hey it's okay
    echo "New file in: "${BACKUP_FOLDER}${DBDUMP_FILENAME}
}
