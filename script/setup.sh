#!/usr/bin/env bash

USER=vagrant
DEPLOY_PATH=/var/www/campo

apt-get update
apt-get install -y curl postgresql libpq-dev redis-server memcached nginx git-core openjdk-7-jre-headless nodejs

cd /tmp
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.deb
dpkg -i elasticsearch-1.0.1.deb
update-rc.d elasticsearch defaults
service elasticsearch start

su postgres <<EOF
  createuser -d -R -S $USER
  createdb campo_production -O $USER
EOF

su $USER <<EOF
  curl -sSL https://get.rvm.io | bash -s stable
  source ~/.rvm/scripts/rvm
  rvm install 2.1.1
  rvm use --default 2.1.1
EOF

mkdir -p $DEPLOY_PATH
chown $USER:$USER $DEPLOY_PATH

wget -O /etc/init.d/unicorn_campo https://raw.github.com/chloerei/campo/master/script/unicorn.sh
chmod +x /etc/init.d/unicorn_campo

wget -O /etc/nginx/sites-available/campo.conf https://raw.github.com/chloerei/campo/master/script/unicorn.sh
ln -s /etc/nginx/sites-available/campo.conf /etc/nginx/sites-enabled/
service nginx restart
