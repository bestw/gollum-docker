FROM ruby:2.6-alpine3.11

ADD entrypoint.sh /bin

RUN apk add --no-cache git openssh-server && \
    addgroup -g 1000 -S git && \
    adduser git -D -G git -u 1000 -s /bin/sh -h /home/git && \
    sed -i '/^PasswordAuthentication/s/^/#/g' /etc/ssh/sshd_config && \
    sed -i '/PasswordAuthentication/a\PasswordAuthentication no' /etc/ssh/sshd_config && \
    apk add --no-cache build-base cmake icu-libs icu-dev openssl-dev && \
    gem install --no-document github-linguist github-markdown gollum && \
    apk del build-base cmake icu-dev openssl-dev && \
    chmod 755 /bin/entrypoint.sh && \
    mkdir /wiki && chown -R 1000:1000 /wiki && \
    rm -rf /var/cache/apk/* /tmp/*

ENV DEPLOY_PUBLIC_KEY=""

WORKDIR /wiki
ENTRYPOINT ["/bin/entrypoint.sh"]
EXPOSE 4567
EXPOSE 22
