#!/bin/sh

if [ $# -lt 1 ]; then
  echo "Usage: $0 HOST-ADDRESS"
  exit 1
fi

ssh $1 mkdir -p .ssh
cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> .ssh/authorized_keys'
