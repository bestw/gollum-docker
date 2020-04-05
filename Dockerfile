FROM ruby:2.6-alpine3.11

RUN apk update && \
    apk add --no-cache build-base cmake git icu-libs icu-dev openssl-dev && \
    gem install --no-document github-linguist github-markdown gollum && \
    apk del build-base cmake icu-dev openssl-dev && \
    rm -rf /var/cache/apk/* && \
    gem sources --clear-all && \
    rm -rf /tmp/* /var/tmp/* /usr/local/bundle/cache/*.gem

WORKDIR /wiki
ENTRYPOINT ["gollum", "--emoji", "--mathjax"]
EXPOSE 4567
