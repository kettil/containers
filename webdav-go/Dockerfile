FROM hacdias/webdav:v4.2.0

COPY config.yml /config.yml

USER 1003:1003

EXPOSE 8080/tcp
VOLUME [ "/data" ]

CMD [ "--config", "/config.yml" ]
