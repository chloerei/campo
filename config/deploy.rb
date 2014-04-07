# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'campo'
set :repo_url, 'git@github.com:chloerei/campo.git'
set :deploy_to, -> { "/var/www/#{fetch(:application)}" }
set :rails_env, 'production'

set :linked_files, %w{config/database.yml config/config.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

namespace :deploy do
  desc "Restart unicorn and resque"
  task :restart do
    invoke 'deploy:passenger:restart'
    invoke 'deploy:resque:restart'
  end
  after :publishing, :restart

  namespace :passenger do
    task :restart do
      on roles(:app) do
        execute :touch, "#{release_path}/tmp/restart.txt"
      end
    end
  end

  namespace :resque do
    %w( start stop restart ).each do |action|
      desc "#{action} resque worker"
      task action do
        on roles(:app) do
          execute :service, :resque, action
        end
      end
    end
  end
end
