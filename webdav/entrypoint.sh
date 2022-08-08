#!/bin/sh
set -e

HTTPD_PREFIX="${HTTPD_PREFIX:-/usr/local/apache2}"

if [ "$USERNAME" != "" ] && [ "$PASSWORD" != "" ]; then
    if [ "$AUTH_TYPE" = "Digest" ]; then
        HASH="$(printf '%s' "$USERNAME:WebDAV:$PASSWORD" | md5sum | awk '{print $1}')"
        printf '%s\n' "$USERNAME:WebDAV:$HASH" > /webdav/config/user.passwd
    else
        htpasswd -B -b -c "/webdav/config/user.passwd" $USERNAME $PASSWORD
    fi
fi

exec "$@"
