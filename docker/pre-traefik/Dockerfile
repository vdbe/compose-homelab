FROM alpine:latest

RUN apk add --no-cache \
    patch \
    yq

COPY ./entrypoint.sh /entrypoint.sh

WORKDIR /workdir

ENTRYPOINT ["/entrypoint.sh"]
