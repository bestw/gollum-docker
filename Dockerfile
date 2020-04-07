FROM ruby:2.6-alpine3.11

RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories && \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories && \
    apk add --no-cache build-base cmake icu-libs icu-dev openssl-dev git openssh-server && \
    gem install --no-document github-linguist github-markdown gollum && \
    apk del build-base cmake icu-dev openssl-dev && \
    rm -rf /var/cache/apk/* &&\
    addgroup -g 1000 -S git && \
    adduser git -D -G git -u 1000 -s /bin/sh -h /home/git && \
    mkdir /wiki && chown -R 1000:1000 /wiki && \
    sed -i '/^PasswordAuthentication/s/^/#/g' /etc/ssh/sshd_config && \
    sed -i '/PasswordAuthentication/a\PasswordAuthentication no' /etc/ssh/sshd_config

ADD entrypoint /bin

ENV DEPLOY_PUBLIC_KEY=""

USER git
WORKDIR /wiki
ENTRYPOINT ["/bin/entrypoint"]
EXPOSE 4567
EXPOSE 22
