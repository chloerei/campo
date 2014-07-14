#!/usr/bin/env bash

source ./script/setup_base.sh

USER=`whoami`
APP_ROOT=/var/www/campo
DB_NAME=campo_production

# Create database
createdb $DB_NAME

# Install Passenger
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates
sudo bash -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' > /etc/apt/sources.list.d/passenger.list"
sudo apt-get update
sudo apt-get install -y nginx-extras passenger

# Production environment
sudo mkdir -p $APP_ROOT
sudo chown $USER:$USER $APP_ROOT
mkdir -p $APP_ROOT/shared/config
cp config/database.example.yml $APP_ROOT/shared/config/database.yml
cp config/secrets.example.yml $APP_ROOT/shared/config/secrets.yml
cp config/config.example.yml $APP_ROOT/shared/config/config.yml
bundle install --path .bundle
sed -i "s/secret_key_base: \w\+/secret_key_base: `bundle exec rake secret`/g" $APP_ROOT/shared/config/secrets.yml

# Resque init script
sudo cp config/resque.example.sh /etc/init.d/resque
sudo chmod +x /etc/init.d/resque
sudo sed -i "s|APP_ROOT=.\+|APP_ROOT=$APP_ROOT/current|" /etc/init.d/resque
sudo sed -i "s/USER=\w\+/USER=$USER/" /etc/init.d/resque
sudo update-rc.d resque defaults

# Nginx config
sudo cp config/nginx.example.conf /etc/nginx/sites-available/campo
sudo sed -i "s|root .\+;|root $APP_ROOT/current/public;|" /etc/nginx/sites-available/campo
sudo ln -s /etc/nginx/sites-available/campo /etc/nginx/sites-enabled
sudo rm /etc/nginx/sites-enabled/default
sudo sed -i 's/# passenger_root/passenger_root/' /etc/nginx/nginx.conf
sudo sed -i 's|pid /run/nginx.pid;|&\nenv PATH;|' /etc/nginx/nginx.conf
sudo service nginx restart

# Firewall
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw logging on
sudo ufw enable
