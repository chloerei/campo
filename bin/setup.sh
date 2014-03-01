#!/usr/bin/env bash

USER=vagrant
DEPLOY_PATH=/var/www/campo

su postgres <<EOF
  createuser -d -R -S $USER
EOF

apt-get update
apt-get install -y curl postgresql redis-server memcached nginx git-core

su $USER <<EOF
  curl -sSL https://get.rvm.io | bash -s stable
  source ~/.rvm/scripts/rvm
  rvm install 2.1.1
  rvm use --default 2.1.1
EOF

mkdir -p $DEPLOY_PATH
chown $USER:$USER $DEPLOY_PATH
