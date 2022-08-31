# Webdav

```bash
docker run --rm -p 8080:8080 -v "$(pwd)/data:/data" \
  -e USERNAME=test \
  -e PASSWORD=test \
  ghcr.io/kettil/webdav-go:latest
```

Source: https://github.com/hacdias/webdav
