#!/bin/sh

if [ ! -f /wiki/HEAD ]; then
  git init --bare /wiki
fi

echo Starting gollum...
gollum --emoji --mathjax $*
