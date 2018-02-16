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

mysql -h$db_host -u$db_user -p$db_pass -e "DROP DATABASE IF EXISTS $db_name"
mysql -h$db_host -u$db_user -p$db_pass -e "CREATE DATABASE $db_name"

rm ./app/etc/env.php
rm ./app/etc/config.php
rm -rf ./var
git checkout ./var/*
rm -rf ./generated
git checkout ./generated/*

is_clean="1" ./bin/install.sh