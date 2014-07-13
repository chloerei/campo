#!/usr/bin/env bash

USER=`whoami`

sudo apt-get update

# Install system packages
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server memcached git-core nodejs imagemagick postfix

# Install Elasticsearch
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo bash -c "echo 'deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main' > /etc/apt/sources.list.d/elasticsearch.list"
sudo apt-get update
sudo apt-get install -y openjdk-7-jre-headless elasticsearch
sudo update-rc.d elasticsearch defaults
sudo service elasticsearch start

# Install PostgreSQL
sudo apt-get install -y postgresql libpq-dev
sudo su postgres -c "createuser -d -R -S $USER"

# Install rvm and ruby
sudo apt-get install -y curl
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.1.1
rvm use --default 2.1.1
