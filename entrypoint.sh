#!/bin/sh
set -e

mkdir -p /app/var

/app/.github/docker/entrypoint.sh

if [ ! -f /app/storage/app/public/.railway_initialized ]; then
    php artisan app:init "$COMPANY_NAME" "$APP_URL"
    php artisan db:seed --class=CustomPropertySeeder --force
    php artisan app:user:create "CHANGEME" "CHANGEME" "$ADMIN_EMAIL" "$ADMIN_PASSWORD" 1
    touch /app/storage/app/public/.railway_initialized
fi

exec "$@"
