# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'campo'
set :repo_url, 'git@github.com:chloerei/campo.git'
set :deploy_to, -> { "/var/www/#{fetch(:application)}" }
set :rails_env, 'production'

set :linked_files, %w{config/database.yml config/config.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

namespace :deploy do
  desc "Upload example config to shared/config"
  task :upload_config do
    on roles(:app) do
      execute "mkdir -p #{deploy_to}/shared/config"
      upload! File.new('config/database.example.yml'), "#{deploy_to}/shared/config/database.yml"
      upload! File.new('config/secrets.example.yml'), "#{deploy_to}/shared/config/secrets.yml"
      upload! File.new('config/config.example.yml'), "#{deploy_to}/shared/config/config.yml"
      info "Now edit the config files in #{shared_path}."
    end
  end

  desc "Restart unicorn and resque"
  task :restart do
    invoke 'deploy:unicorn:restart'
    invoke 'deploy:resque:restart'
  end
  after :publishing, :restart

  namespace :unicorn do
    %w( start stop restart upgrade ).each do |action|
      desc "#{action} unicorn"
      task action do
        on roles(:app) do
          execute "/etc/init.d/unicorn_#{fetch(:application)}", action
        end
      end
    end
  end

  namespace :resque do
    %w( start stop restart ).each do |action|
      desc "#{action} resque worker"
      task action do
        on roles(:app) do
          execute "/etc/init.d/resque_#{fetch(:application)}", action
        end
      end
    end
  end
end
