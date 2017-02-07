#!/bin/bash

function wordpress-db-specifics {

    if [[ $1 = 'local' ]]; then
        MYSQL_COMMAND=${MYSQL_LOCAL_COMMAND}
        NEW_URL=${LOCAL_URL}
        OLD_URL=${REMOTE_URL}
    elif [[ $1 = 'remote' ]]; then
        MYSQL_COMMAND="ssh ${REMOTE_SSH_USER}@${REMOTE_SSH_HOST} ${MYSQL_REMOTE_COMMAND}"
        NEW_URL=${REMOTE_URL}
        OLD_URL=${LOCAL_URL}
    else
        die "wordpress-db-specifics needs an argument (local or remote)"
    fi

    # After an import of a new database, we need to change the site urls in the database
    echo "UPDATE wp_options SET option_value = REPLACE(option_value, '${OLD_URL}', '${NEW_URL}') WHERE option_name = 'home' OR option_name = 'siteurl';
    UPDATE wp_posts SET post_content = REPLACE (post_content, '${OLD_URL}', '${NEW_URL}');
    UPDATE wp_postmeta SET meta_value = REPLACE (meta_value, '${OLD_URL}','${NEW_URL}');
    UPDATE wp_comments SET comment_content = REPLACE (comment_content, '${OLD_URL}', '${NEW_URL}');
    UPDATE wp_comments SET comment_author_url = REPLACE (comment_author_url, '${OLD_URL}','${NEW_URL}');
    UPDATE wp_posts SET guid = REPLACE (guid, '${OLD_URL}', '${NEW_URL}');" > tmp_urls_to_refresh.sql
    ${MYSQL_COMMAND} < tmp_urls_to_refresh.sql

    echo "Urls updated!"
}

# Create wp-config.php
function generate-wp-config-php {

    WPCONFIG_PATH=${DIR}gitignored-files/wp-config.php
    mkdir ${DIR}gitignored-files/
    
    # Generate the final wp-config.php based on template file
    cat "${DIR}templates/wordpress/default.wp-config.php" | sed \
    -e "s,_REMOTE_SQL_HOST,${REMOTE_SQL_HOST}," \
    -e "s,_REMOTE_SQL_USER,${REMOTE_SQL_USER}," \
    -e "s,_REMOTE_SQL_PASSWORD,${REMOTE_SQL_PASSWORD}," \
    -e "s,_REMOTE_SQL_DATABASE,${REMOTE_SQL_DATABASE}," \
     > "${WPCONFIG_PATH}"

     echo -e "Please check the generated wp-config.php"
}
