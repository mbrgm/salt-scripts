#!/bin/bash

GPG_KEY=0E08A149DE57BFBE

echo "deb http://repo.saltstack.com/apt/debian/8/amd64/latest jessie main" > /etc/apt/sources.list.d/saltstack.list
gpg --keyserver pgp.mit.edu --recv-keys ${GPG_KEY}
gpg --armor --export ${GPG_KEY} | apt-key add -
apt-get update
apt-get install -y salt-master
echo "127.0.0.1	salt" >> /etc/hosts
salt-call --local --file-root state/ --pillar-root pillar/ state.sls salt.master,salt.minion
salt-key -a $(hostname -f) -y
salt "$(hostname -f)" state.highstate
