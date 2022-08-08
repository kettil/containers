#!/bin/sh
set -e

HTTPD_PREFIX="${HTTPD_PREFIX:-/usr/local/apache2}"

if [ "$AUTH_TYPE" != "" ]; then
    # Only support "Basic" and "Digest".
    if [ "$AUTH_TYPE" != "Basic" ] && [ "$AUTH_TYPE" != "Digest" ]; then
        printf '%s\n' "$AUTH_TYPE: Unknown AuthType" 1>&2
        exit 1
    fi
    sed -e "s|AuthType .*|AuthType $AUTH_TYPE|" -i "$HTTPD_PREFIX/conf/conf-available/dav.conf"
fi

if [ ! -e "/user.passwd" ]; then
    touch "/user.passwd"
    if [ "$USERNAME" != "" ] && [ "$PASSWORD" != "" ]; then
        if [ "$AUTH_TYPE" = "Digest" ]; then
            HASH="$(printf '%s' "$USERNAME:WebDAV:$PASSWORD" | md5sum | awk '{print $1}')"
            printf '%s\n' "$USERNAME:WebDAV:$HASH" > /user.passwd
        else
            htpasswd -B -b -c "/user.passwd" $USERNAME $PASSWORD
        fi
    fi
fi

[ ! -d "/webdav/data" ] && mkdir -p "/webdav/data"
[ ! -d "/webdav/lock" ] && mkdir -p "/webdav/lock"
[ ! -e "/webdav/lock/davLock" ] && touch "/webdav/lock/davLock"
chown -R www-data:www-data "/webdav"

exec "$@"
