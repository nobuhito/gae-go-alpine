FROM golang:1.7-alpine
MAINTAINER Nobuhito SATO <nobuhito.sato@gmail.com>

ENV SDK=https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip \
    PACKAGES="curl unzip" \
    CLOUD_SDK=/google-cloud-sdk \
    PATH=/google-cloud-sdk/bin:${PATH} \
    GOROOT=/usr/local/go

RUN apk add --update --no-cache git python ${PACKAGES} && \
    curl -fo /tmp/gae.zip ${SDK} && unzip -q /tmp/gae.zip -d /tmp/ && mv /tmp/google-cloud-sdk ${CLOUD_SDK} && \
    ${CLOUD_SDK}/install.sh --usage-reporting=true --path-update=true --disable-installation-options --bash-completion=false && \
    yes | gcloud components install app-engine-go && \
    apk del ${PACKAGES} --no-cache && rm -rf /tmp/* /var/cache/apk/*
