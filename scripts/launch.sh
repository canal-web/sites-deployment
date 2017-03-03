#!/bin/bash

# Check if someone already launched the project
function check-launched {
    
    # has the flag already been generated ?
    if [[ -f ${DIR}gitignored-files/.launched ]]; then
    # if so, please confirm
        read -p "It seems the project has already been launched once. Do you want to run the launching steps again anyway? (y/n)" choice
        case "$choice" in
          y|Y ) echo "Ok, bro.";;
          n|N ) die "Aborted by user.";;
          * ) die "Abort: invalid answer.";;
        esac
    # else, generate the flag and continue
    else
        echo "true">${DIR}gitignored-files/.launched
    fi
}

# Generate settings files
function generate-settings {

    # CMS-dependant files
    if [[ ${USED_CMS} == 'magento' ]]; then
        echo "Congratulations, what a beautiful Magento!"
        generate-local-xml
    elif [[ ${USED_CMS} == 'drupal' ]]; then
        echo "Congratulations, what a beautiful Drupal!"
        generate-settings-php
    elif [[ ${USED_CMS} == 'wordpress' ]]; then
        echo "Congratulations, what a beautiful Wordpress!"
        generate-wp-config-php
    fi
}

function generate-default-gitignored-files {
    # Generate .htaccess
    if [[ -f ${LOCAL_ROOTDIR}.htaccess ]]; then
        cp ${LOCAL_ROOTDIR}.htaccess ${DIR}gitignored-files/
    fi

    # Generate robots.txt (CMS-dependant)
    if [[ ${USED_CMS} == 'magento' ]]; then
        cp ${DIR}templates/magento/default.robots.txt ${DIR}gitignored-files/robots.txt
    elif [[ ${USED_CMS} == 'drupal' ]]; then
        cp ${DIR}templates/drupal/default.robots.txt ${DIR}gitignored-files/robots.txt
    elif [[ ${USED_CMS} == 'wordpress' ]]; then
        cp ${DIR}templates/wordpress/default.robots.txt ${DIR}gitignored-files/robots.txt
    fi
    echo -e "Default robots.txt has been copied. Please add your specific non-crawlables paths and sitemaps."
}

function additionnal-operations {
    # If needed, do extras operations - specified in a non-gitted file (ex: import-related)
    if [[ -f ${DIR}"/gitignored-files/extra-operations.sh" ]]; then
        source ${DIR}gitignored-files/extra-operations.sh
    fi
}

# Compass/Gulp with production settings
function assets-compilation {
    cd ${LOCAL_ROOTDIR}${SKIN_DIR}
    if [[ -f "gulpfile.js" ]]; then
        gulp --env prod
    elif [[ -f "config.rb" ]]; then
        compass compile -e production --force
    elif [[ -f "scss/config.rb" ]]; then
        cd scss
        compass compile -e production --force
    elif [[ -f "sass/config.rb" ]]; then
        cd sass
        compass compile -e production --force
    fi
    cd ${DIR}
    echo -e ""
}
