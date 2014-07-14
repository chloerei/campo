#!/usr/bin/env bash

source ./script/setup_base.sh

# Development environment
cp config/database.example.yml config/database.yml
cp config/secrets.example.yml config/secrets.yml
cp config/config.example.yml config/config.yml
bundle install --path .bundle
bundle exec rake db:create:all db:setup
