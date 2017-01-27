#!/bin/bash

# Check if local settings file is present
if [[ ! -f "${DIR}/settings/local_params.sh" ]]; then
    die "You must copy settings/default.local_params.sh to settings/local_params.sh and fill it with your distant server/database informations to continue"
fi
source "${DIR}/settings/local_params.sh"

# Check if remote settings file is present
if [[ ! -f "${DIR}/settings/remote_params.sh" ]]; then
    die "You must copy settings/default.remote_params.sh to settings/remote_params.sh and fill it with your distant server/database informations to continue"
fi
source "${DIR}/settings/remote_params.sh"

# Check if current user is the owner of current dir
OWNER=`stat -c '%U' ${DIR}`
if [[ ${OWNER} != ${USER} ]]; then
    die "${OWNER} shall be the name thou shalt su, and the name of the su shall be ${OWNER}"
fi

# Define used CMS
function define_cms {
    if [[ ${USED_CMS} == false && -d ${LOCAL_ROOTDIR}"app/etc/" ]]; then
        USED_CMS="magento"
    elif [[ ${USED_CMS} == false && -f ${LOCAL_ROOTDIR}"sites/default/default.settings.php" ]]; then
        USED_CMS="drupal"
    elif [[ ${USED_CMS} == false && -d ${LOCAL_ROOTDIR}"wp-content" ]]; then
        USED_CMS="wordpress"
    fi
}
define_cms
