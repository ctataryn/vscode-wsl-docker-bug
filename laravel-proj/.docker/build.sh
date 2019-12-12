#!/usr/bin/env bash
set -e

source ./.env

composer global require hirak/prestissimo
composer install --no-suggest --optimize-autoloader ${COMPOSER_INSTALL_ARGS}

# phpDoc generation for Laravel Facades
php artisan clear-compiled

# Allow file-system modifications where needed
chmod -R a+w storage
chmod -R a+w bootstrap/cache
