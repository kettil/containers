#!/bin/sh
set -e

HTTPD_PREFIX="${HTTPD_PREFIX:-/usr/local/apache2}"

if [ "$USERNAME" != "" ] && [ "$PASSWORD" != "" ]; then
    htpasswd -B -n -b $USERNAME $PASSWORD > "/webdav/config/user.passwd"
fi

exec "$@"
