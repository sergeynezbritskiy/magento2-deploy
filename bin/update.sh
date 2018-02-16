#!/bin/bash

php bin/magento maintenance:enable

. ./bin/config.sh

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

echo -e '\E[47;31m'"\033[1mMAGENTO 2 CONFIGURING:\033[0m"
echo -e '\E[47;31m'"\033[1mMAGENTO cache:clean\033[0m"
php bin/magento cache:clean
echo -e '\E[47;31m'"\033[1mMAGENTO setup:upgrade\033[0m"
php bin/magento setup:upgrade
echo -e '\E[47;31m'"\033[1mMAGENTO setup:di:compile\033[0m"
php bin/magento setup:di:compile
echo -e '\E[47;31m'"\033[1mMAGENTO setup:static-content:deploy\033[0m"
#php bin/magento setup:static-content:deploy -f
echo -e '\E[47;31m'"\033[1mMAGENTO indexer:reindex\033[0m"
php bin/magento indexer:reindex
echo -e '\E[47;31m'"\033[1mMAGENTO cache:clean\033[0m"
php bin/magento cache:clean

php bin/magento maintenance:disable