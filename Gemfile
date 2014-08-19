source 'https://rubygems.org'

gem 'rails', '4.1.5'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',     platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# Wait for https://github.com/rails/turbolinks/pull/364
gem 'turbolinks', github: 'chloerei/turbolinks', branch: 'reset-scroll-position'

# Bootstrap
gem 'bootstrap-sass', '~> 3.1.0'

# Font Awesome
gem 'font-awesome-sass', '~> 4.1.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# bundle exec rake doc:rails generates the API under doc/api.
#gem 'sdoc',             group: :doc, require: false

# Slim template
gem 'slim', '~> 2.0.2'

# Markdown
gem 'redcarpet', '~> 3.0.0'

# Code highlight
gem 'rouge', '~> 1.3.1'

# require: false so bcrypt is loaded only when has_secure_password is used.
# This is to avoid ActiveModel (and by extension the entire framework)
# being dependent on a binary library.
gem 'bcrypt', '~> 3.1.7', require: false

# Paginator
gem 'kaminari', '~> 0.15.1'

# Nokogiri XML parser
gem 'nokogiri', '~> 1.6.1'

# Gravatar
gem 'gravtastic', '~> 3.2.6'

# Elasticsearch
gem 'elasticsearch-model', '~> 0.1.0'
gem 'elasticsearch-rails', '~> 0.1.0'

# File upload
gem 'carrierwave', '~> 0.9.0'
gem 'mini_magick', '~> 3.7.0'

# User locale detect
gem 'http_accept_language', '~> 2.0.1'

# i18n
gem 'rails-i18n', '~> 4.0.1'

# redis
gem 'redis', '~> 3.0.7'
gem 'hiredis', '~> 0.4.5'

# Background jobs
gem 'resque', '~> 1.25.1'
gem 'resque_mailer', '~> 2.2.6'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/jonleighton/spring
  gem 'spring'

  # Livereload
  gem 'guard-livereload', require: false
  gem 'rack-livereload'

  # i18n extractor
  gem 'i18n-tasks', '~> 0.3.2'

  # Deploy tool
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.0.0'
end

group :development, :test do
  gem 'factory_girl_rails', '~> 4.3.0'
end
