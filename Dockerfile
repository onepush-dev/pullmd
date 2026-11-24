# PullMD on Railway: the official aeternalabshq/pullmd:3.21.0 image (AGPL-3.0), application unmodified.
# Railway layer: authentication on (single-admin, admin password generated per deploy), public history off,
# SQLite cache on the /data volume, one trusted proxy hop (Railway's edge), listening on 8080.
FROM aeternalabshq/pullmd:3.21.0
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/pullmd"
ENV PORT=8080 \
    PULLMD_AUTH_MODE=single-admin \
    PULLMD_ADMIN_EMAIL=admin@pullmd.local \
    DISABLE_PUBLIC_HISTORY=true \
    PULLMD_TRUST_PROXY=1 \
    CACHE_DB=/data/cache.db
EXPOSE 8080
