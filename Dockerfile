FROM alpine

ARG SSR_URL=https://github.com/shadowsocksr-backup/shadowsocksr/archive/manyuser.zip

RUN set -ex && \
    apk add --no-cache libsodium py-pip && \
    pip --no-cache-dir install $SSR_URL

WORKDIR /app

COPY config/config.json .

CMD ["ssserver", "-c", "config.json"]
