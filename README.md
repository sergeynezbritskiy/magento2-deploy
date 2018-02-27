This package allows you easily install magento 2 from scratch, setup already existing project within new location, and update existing projects
## Installation
The easiest way to install module is using Composer
```
composer require sergeynezbritskiy/magento2-deploy
php vendor/sergeynezbritskiy/magento2-deploy/init
php bin/magento setup:upgrade
php bin/magento setup:di:compile
php bin/magento cache:clean
```
    
## Magento command usage
```
php bin/magento deploy:mode:configure [DEPLOY_MDOE]
```
## Deploy scripts usage
copy `bin/config.sh.sample` file to `bin/config.sh` and setup  configuration according to your environment
from your root directory run:
```
./bin/clean.sh //completely reinstall magento according DROPPING DATABASE
./bin/install.sh //install magento from scratch
./bin/update.sh //update magento, e.g. after `git pull`
```
