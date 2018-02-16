#!/bin/bash

. ./bin/config.sh

# Check db_host value
if [ -z "$db_host" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your db-host. Example: localhost \033[0m"
    read db_host
fi


# Check db_name value
if [ -z "$db_name" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your existing database. Example: magento2 \033[0m"
    read db_name
fi


# Check db_user
if [ -z "$db_user" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your DB user. Example: root \033[0m"
    read db_user
fi

# Check db_pass
if [ -z "$db_pass" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your DB user password. Example: rootpassword \033[0m"
    read db_pass
fi

# Check mage_base_url
if [ -z "$mage_base_url" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your base url for magento(it is your virtual host name). Example: http://magento2.local \033[0m"
    read mage_base_url
fi

# Check mage_admin_user value
if [ -z "$mage_admin_user" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter admin user name. Example: admin_user \033[0m"
    read mage_admin_user
fi

#get admin first name
if [ -z "$mage_admin_firstname" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter admin user firstname. Example: Firstname \033[0m"
    read mage_admin_firstname
fi

# Check mage_admin_lastname
if [ -z "$mage_admin_lastname" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter admin user Lastname. Example: Lastname \033[0m"
    read mage_admin_lastname
fi

# Check mage_admin_email
if [ -z "$mage_admin_email" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter admin user email. Example: m.kindgeek@kindgeek.com \033[0m"
    read mage_admin_email
fi

# Check mage_admin_pass value
if [ -z "$mage_admin_pass" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter admin user password(For login to admin panel). Example: kindgeek123 \033[0m"
    read mage_admin_pass
fi

# Check mage_admin_path value
if [ -z "$mage_admin_path" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your path to admin panel.Example: admin \033[0m"
    read mage_admin_path
fi

# Check deploy_mode value
if [ -z "$deploy_mode" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your deploy mode: developer, default or production\033[0m"
    read deploy_mode
fi

if [ -z "$magento_com_username" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your username to magento.com repo\033[0m"
    read magento_com_username
fi

if [ -z "$magento_com_password" ]
  then
    echo -e '\E[47;35m'"\033[1mPlease enter your password to magento.com repo\033[0m"
    read magento_com_password
fi

echo -e '\E[47;31m'"\033[1mCOMPOSER INSTALL:\033[0m"

composer config http-basic.repo.magento.com $magento_com_username $magento_com_password
composer install

echo -e '\E[47;31m'"\033[1mMAGENTO 2 INSTALLATION:\033[0m"
php -f bin/magento setup:install --db-host="$db_host" --db-name="$db_name" --db-user="$db_user" --db-password="$db_pass" --base-url="$mage_base_url" --admin-user="$mage_admin_user" --admin-firstname="$mage_admin_firstname" --admin-lastname="$mage_admin_lastname" --admin-email="$mage_admin_email" --admin-password="$mage_admin_pass" --language="en_US" --currency="USD" --backend-frontname="$mage_admin_path" --use-rewrites="1"

if [ "$deploy_mode" == "developer" ]
  then
    cp ./pub/errors/local.xml.sample ./pub/errors/local.xml
fi

echo -e '\E[47;31m'"\033[1mMAGENTO set deploy mode\033[0m"
php bin/magento deploy:mode:set $deploy_mode

echo -e '\E[47;31m'"\033[1mMAGENTO 2 CONFIGURING:\033[0m"
echo -e '\E[47;31m'"\033[1mMAGENTO cache:clean\033[0m"
php bin/magento cache:clean
echo -e '\E[47;31m'"\033[1mMAGENTO setup:upgrade\033[0m"
php bin/magento setup:upgrade
echo -e '\E[47;31m'"\033[1mMAGENTO setup:di:compile\033[0m"
php bin/magento setup:di:compile
echo -e '\E[47;31m'"\033[1mconfigure developer mode suitable settings\033[0m"
if [ "$deploy_mode" == "developer" ]
  then
    php bin/magento magecom:developer-mode:configure
fi
#echo -e '\E[47;31m'"\033[1mMAGENTO setup:static-content:deploy\033[0m"
#php bin/magento setup:static-content:deploy -f
echo -e '\E[47;31m'"\033[1mMAGENTO indexer:reindex\033[0m"
php bin/magento indexer:reindex
echo -e '\E[47;31m'"\033[1mMAGENTO cache:clean\033[0m"
php bin/magento cache:clean
