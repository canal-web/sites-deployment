#!/bin/bash
set -e
function die
{
    echo -e "$@" >&2
    exit 1
}

DIR=`dirname $0`
DIR=`readlink -f $DIR`
DIR=${DIR}/

USED_CMS=false

RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh

# No-flag or wrong-flag message
NOFLAG_MSG="No valid option specified.\n
Valid options are: \n
- launch \n
- update \n
- backup-remote \n
- db-to-remote \n
- db-to-local \n
- media-to-remote \n
- media-to-local \n"

# Run checks and declare functions
for f in scripts/*; do
   source $f
done

# Run checks and declare functions
for f in cms-specifics/*; do
   source $f
done

# Shortcut for a connexion to local database
MYSQL_LOCAL_COMMAND="mysql -h${LOCAL_SQL_HOST} -u${LOCAL_SQL_USER} -p${LOCAL_SQL_PASSWORD} ${LOCAL_SQL_DATABASE}"

# Shortcut for a connexion to local database
MYSQL_REMOTE_COMMAND="mysql -h${REMOTE_SQL_HOST} -u${REMOTE_SQL_USER} -p${REMOTE_SQL_PASSWORD} ${REMOTE_SQL_DATABASE}"

# Manage flags
case $1 in
    launch)
        check-launched
        generate-settings
        generate-default-gitignored-files
        additionnal-operations
        assets-compilation
        rsync-httpdocs
        rsync-gitignored
        db-to-remote
        media-to-remote
    ;;
    update)
        assets-compilation
        rsync-httpdocs
        rsync-gitignored
    ;;
    backup-remote)
        echo "Roquette will now backup distant database..."
        backup-remote gz
    ;;
    db-to-remote)
        echo "Roquette will now copy local database to the remote one."
        db-to-remote
    ;;
    db-to-local)
        echo "Roquette will now copy remote database to the local one."
        db-to-local
    ;;
    media-to-remote)
        media-to-remote
    ;;
    media-to-local)
        media-to-local
    ;;
    *)
        die ${NOFLAG_MSG}
    ;;
esac
