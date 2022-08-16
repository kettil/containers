FROM httpd:2.4.54

# Copy in our configuration files.
COPY dav.conf     conf/conf-available/dav.conf
COPY default.conf conf/sites-available/default.conf

RUN set -ex; \
  mkdir -p "/var/www/html" "/webdav/data" "/webdav/config"; \
  touch "/webdav/config/davLock"; \
  touch "/webdav/config/user.passwd"; \
  chown -R www-data:www-data "/webdav"; \
  sed -i -e "/^#LoadModule alias_module.*/s/^#//"          "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule auth_basic_module.*/s/^#//"     "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authn_core_module.*/s/^#//"     "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authn_file_module.*/s/^#//"     "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authz_core_module.*/s/^#//"     "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule authz_user_module.*/s/^#//"     "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule dav_fs_module.*/s/^#//"         "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule dav_module.*/s/^#//"            "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule headers_module.*/s/^#//"        "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule http2_module.*/s/^#//"          "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule mime_module.*/s/^#//"           "conf/httpd.conf"; \
  sed -i -e "/^#LoadModule setenvif_module.*/s/^#//"       "conf/httpd.conf"; \
  sed -i -e "s|^#ServerName .*|ServerName localhost|"      "conf/httpd.conf"; \
  sed -i -e "s|^User .*|User www-data|"                    "conf/httpd.conf"; \
  sed -i -e "s|^Group .*|Group www-data|"                  "conf/httpd.conf"; \
  sed -i -e "s|^Listen .*|Listen 8080|"                    "conf/httpd.conf"; \
  printf '%s\n' "Include conf/conf-enabled/*.conf"      >> "conf/httpd.conf"; \
  printf '%s\n' "Include conf/sites-enabled/*.conf"     >> "conf/httpd.conf"; \
  printf '%s\n' "PidFile \"/webdav/config/httpd.pid\""  >> "conf/httpd.conf"; \
  mkdir -p "conf/conf-enabled"; \
  mkdir -p "conf/sites-enabled"; \
  ln -s ../conf-available/dav.conf "conf/conf-enabled"; \
  ln -s ../sites-available/default.conf "conf/sites-enabled";

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 8080/tcp

#          33:33
USER www-data:www-data

VOLUME [ "/webdav/data", "/webdav/config" ]

ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "httpd-foreground" ]
