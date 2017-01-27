#!/bin/bash

# Create sites/default/settings.php
function generate-settings-php {

    SETTINGSPHP_PATH=${DIR}gitignored-files/sites/default/settings.php
    mkdir ${DIR}gitignored-files/sites/default -p

    # Generate the final settings.php based on template file
    cat "${DIR}templates/drupal/default.settings.php" | sed \
    -e "s,_REMOTE_SQL_HOST,${REMOTE_SQL_HOST}," \
    -e "s,_REMOTE_SQL_USER,${REMOTE_SQL_USER}," \
    -e "s,_REMOTE_SQL_PASSWORD,${REMOTE_SQL_PASSWORD}," \
    -e "s,_REMOTE_SQL_DATABASE,${REMOTE_SQL_DATABASE}," \
     > "${SETTINGSPHP_PATH}"

     echo -e "Please check the generated settings.php"
}
