#!/usr/bin/env bash

set -e

echo "Caching configuration..."
(cd /var/www/html && php artisan config:cache)

exec apache2-foreground
