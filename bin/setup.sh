#!/usr/bin/env bash

# Change app root, use for vagrant
if [ ! -z "$1" ]; then
  cd $1
fi

# Fix postgresql default encoding because update-locale not effect without logout
export LC_ALL=en_US.UTF-8
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y curl postgresql libpq-dev redis-server memcached git-core openjdk-7-jre-headless nodejs imagemagick postfix

cd /tmp
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.deb
sudo dpkg -i elasticsearch-1.0.1.deb
sudo update-rc.d elasticsearch defaults
sudo service elasticsearch start
cd -

sudo su postgres -c "createuser -d -R -S `whoami`"

curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.1.1
rvm use --default 2.1.1

bundle install

cp config/database.example.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
cp config/config.example.yml config/config.yml

rake db:create db:migrate
