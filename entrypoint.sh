#!/bin/sh

if [ ! -f ~/.ran ]; then
  ssh-keygen -A
  if [ -n "${DEPLOY_PUBLIC_KEY}" ]; then
    mkdir -p /home/git/.ssh
    echo ${DEPLOY_PUBLIC_KEY} > /home/git/.ssh/authorized_keys
    chown 1000:1000 -R /home/git/.ssh
    chmod 700 /home/git/.ssh
    chmod 600 -R /home/git/.ssh/*
  fi
  touch ~/.ran
fi

if [ ! -d /wiki/.git ]; then
  git init /wiki
  chown 1000:1000 -R /wiki
fi

echo Starting sshd...
/usr/sbin/sshd -D &

echo Starting gollum...
gollum --emoji --mathjax $*
