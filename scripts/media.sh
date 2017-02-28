#!/bin/bash

# Define media dir based on CMS
if [[ ${USED_CMS} == 'magento' ]]; then
    MEDIA_DIR="media/"
elif [[ ${USED_CMS} == 'drupal' ]]; then
    MEDIA_DIR="sites/default/files/"
elif [[ ${USED_CMS} == 'wordpress' ]]; then
    MEDIA_DIR="wp-content/uploads/"
fi

function media-to-remote {

    # ALERT
    read -p "You are about to erase the media directory of a production website. Are you really really reallllly sure you wanna do that, bro? (y/n)" choice
    case "$choice" in
      y|Y ) echo "Ok, bro.";;
      n|N ) die "Aborted by user.";;
      bro ) fortune;;
      * ) die "Abort: invalid answer.";;
    esac

    ${RSYNC} -a --no-o --no-g -z -e ssh --stats ${LOCAL_ROOTDIR}${MEDIA_DIR}* ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_ROOTDIR}${MEDIA_DIR}

    # CMS SPECIFICS
    if [[ ${USED_CMS} == 'magento' ]]; then
        clear-magento-cache
    elif [[ ${USED_CMS} == 'drupal' ]]; then
        clear-drupal-cache
    fi

    echo 'Local media files sent to remote.'
}

function media-to-local {
    ${RSYNC} -a --no-o --no-g -z -e ssh --stats ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}:${REMOTE_ROOTDIR}${MEDIA_DIR}* ${LOCAL_ROOTDIR}${MEDIA_DIR}

    echo 'Media files fetched from remote.'
}
