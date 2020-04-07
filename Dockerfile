FROM ruby:2.6-alpine3.11

ADD entrypoint.sh /bin

RUN apk add --no-cache build-base cmake icu-libs icu-dev openssl-dev git && \
    gem install --no-document github-linguist github-markdown gollum && \
    apk del build-base cmake icu-dev openssl-dev && \
    chmod 755 /bin/entrypoint.sh && \
    rm -rf /var/cache/apk/* /tmp/*

WORKDIR /wiki
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 4567
