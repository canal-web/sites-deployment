#!/bin/bash

function rsync-httpdocs {
    TEMPLATE_DIR=${DIR}templates/${USED_CMS}/
    if [[ -f ${TEMPLATE_DIR}rsync_exclude.txt ]]; then
        EXCLUDE_LIST=${TEMPLATE_DIR}'rsync_exclude.txt'
    else
        EXCLUDE_LIST=${TEMPLATE_DIR}'default.rsync_exclude.txt'
    fi
    ${RSYNC} -a --no-o --no-g -z --exclude-from=${EXCLUDE_LIST} -e ssh --delete --stats ${LOCAL_ROOTDIR} ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_ROOTDIR}
}

function rsync-gitignored {
    GITIGNORED_DIR=${DIR}/gitignored-files/
    # Bacon sonorites
    ${RSYNC} -a --no-o --no-g -z -e ssh --stats ${GITIGNORED_DIR} ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_ROOTDIR}
}
