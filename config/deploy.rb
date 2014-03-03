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

  desc "Start application"
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      puts capture(:whoami)
      execute "/etc/init.d/unicorn_#{fetch(:application)}", :start
    end
  end

  desc "Stop application"
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "/etc/init.d/unicorn_#{fetch(:application)}", :stop
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "/etc/init.d/unicorn_#{fetch(:application)}", :restart
    end
  end

  after :publishing, :restart
end
