#!/bin/sh
set -e

if [ ! -f /var/www/html/vendor/autoload.php ]; then
    composer install --no-dev --optimize-autoloader
fi

if [ ! -d /var/www/html/node_modules ]; then
    npm ci && npm run build
fi

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

