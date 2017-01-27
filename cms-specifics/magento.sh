#!/bin/bash

function magento-db-specifics {

    if [[ $1 = 'local' ]]; then
        MYSQL_COMMAND=${MYSQL_LOCAL_COMMAND}
        NEW_URL=${LOCAL_URL}
    elif [[ $1 = 'remote' ]]; then
        MYSQL_COMMAND="ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} ${MYSQL_REMOTE_COMMAND}"
        NEW_URL=${REMOTE_URL}
    else
        die "magento-db-specifics needs an argument (local or remote)"
    fi
    # After an import of a new database, we need to change URLs in database
    echo "select config_id from core_config_data where path like '%base_url%' and scope = 'default';" > tmp_get_config_id_for_baseurl.sql
    ${MYSQL_COMMAND} < tmp_get_config_id_for_baseurl.sql > tmp_config_ids

    while read p; do
        if [[ $p != 'config_id' ]]; then
            echo "update core_config_data set value = \"${NEW_URL}\" where config_id = ${p};" > tmp_change_urls_query.sql
            ${MYSQL_COMMAND} < tmp_change_urls_query.sql
        fi
    done <tmp_config_ids

    rm tmp_change_urls_query.sql
    rm tmp_get_config_id_for_baseurl.sql
    rm tmp_config_ids

    echo "Urls updated!"
}

# Create app/etc/local.xml
function generate-local-xml {

    LOCALXML_PATH=${DIR}gitignored-files/app/etc/local.xml
    mkdir ${DIR}gitignored-files/app/etc -p

    # Generate the final local.xml based on template file
    cat "${DIR}templates/magento/default.app.local.xml" | sed \
    -e "s,_REMOTE_SQL_HOST,${REMOTE_SQL_HOST}," \
    -e "s,_REMOTE_SQL_USER,${REMOTE_SQL_USER}," \
    -e "s,_REMOTE_SQL_PASSWORD,${REMOTE_SQL_PASSWORD}," \
    -e "s,_REMOTE_SQL_DATABASE,${REMOTE_SQL_DATABASE}," \
    -e "s,_REMOTE_ADMIN_PATH,${REMOTE_ADMIN_PATH}," \
    -e "s,_REMOTE_URL_UNSECURE,${REMOTE_URL_UNSECURE}," \
    -e "s,_REMOTE_URL_SECURE,${REMOTE_URL_SECURE}," \
     > "${LOCALXML_PATH}"

     echo -e "Please check the generated local.xml\nAlso, note that only base urls for the default scope are specified, so you will need to get your hands dirty to add store-specified urls, if needed."
}
