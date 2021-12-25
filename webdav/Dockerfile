FROM httpd:2.4.52

# Copy in our configuration files.
COPY dav.conf     conf/conf-available/dav.conf
COPY default.conf conf/sites-available/default.conf

RUN set -ex; \
  mkdir -p "/var/www/html" "/webdav/data"; \
  touch "/webdav/DavLock"; \
  chown -R www-data:www-data "/webdav"; \
  sed -i -e "/^#LoadModule dav_module.*/s/^#//"         "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule dav_fs_module.*/s/^#//"      "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authn_core_module.*/s/^#//"  "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authn_file_module.*/s/^#//"  "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authz_core_module.*/s/^#//"  "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authz_user_module.*/s/^#//"  "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule auth_basic_module.*/s/^#//"  "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule auth_digest_module.*/s/^#//" "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule alias_module.*/s/^#//"       "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule headers_module.*/s/^#//"     "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule mime_module.*/s/^#//"        "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule setenvif_module.*/s/^#//"    "conf/httpd.conf"; \
  sed -i -e "s|^User .*|User www-data|"                 "conf/httpd.conf"; \
  sed -i -e "s|^Group .*|Group www-data|"               "conf/httpd.conf"; \
  printf '%s\n' "Include conf/conf-enabled/*.conf"  >> "conf/httpd.conf"; \
  printf '%s\n' "Include conf/sites-enabled/*.conf" >> "conf/httpd.conf"; \
  mkdir -p "conf/conf-enabled"; \
  mkdir -p "conf/sites-enabled"; \
  ln -s ../conf-available/dav.conf "conf/conf-enabled"; \
  ln -s ../sites-available/default.conf "conf/sites-enabled";

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 80/tcp

VOLUME [ "/webdav" ]

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "httpd-foreground" ]
