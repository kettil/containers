FROM alpine:edge

RUN addgroup --gid 1003 --system app                      \
  && adduser --uid 1003 --system -D -H --ingroup app app  \
  && mkdir -p /app && chown -R app:app /app               \
  && apk --no-cache add imapsync=2.200-r0

WORKDIR /app

USER 1003:1003

ENTRYPOINT [ "/usr/bin/imapsync" ]
CMD [ "--help" ]
