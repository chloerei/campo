
desc "Do all provision"
task :provision do
  invoke 'provision:update'
  invoke 'provision:postgresql'
  invoke 'provision:elasticsearch'
  invoke 'provision:rvm'
  invoke 'provision:server'
  invoke 'provision:unicorn_init_script'
  invoke 'provision:nginx_conf'
  invoke 'provision:prepare_deploy_to'
end

namespace :provision do
  task :as_root do
    on roles(:all) do |host|
      # Overwrite ssh username
      host.define_singleton_method :username do
        'root'
      end
    end
  end

  desc "Update apt-get"
  task :update => :as_root do
    on roles(:all) do |host|
      execute('apt-get update')
    end
  end

  desc "Install postgresql"
  task :postgresql => :as_root do
    on roles(:all) do |host|
      execute('apt-get install -y postgresql libpq-dev')
      as user: 'postgres' do
        test(*%W(createuser -d -R -S #{host.user}))
        test(*%W(createdb campo_production -O #{host.user}))
      end
    end
  end

  desc "Install elasticsearch"
  task :elasticsearch => :as_root do
    on roles(:all) do |host|
      execute('apt-get install -y openjdk-7-jre-headless')
      execute('wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.deb -O elasticsearch-1.0.1.deb -q')
      execute('dpkg -i elasticsearch-1.0.1.deb')
      execute('update-rc.d elasticsearch defaults')
      execute('service elasticsearch start')
    end
  end

  desc "Install rvm"
  task :rvm => :as_root do
    on roles(:all) do |host|
      # Install all dependency, disable autolibs, avoid sudo
      execute('apt-get -y install curl gawk g++ make libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev')
      as user: host.user do
        execute(*%W(curl -sSL https://get.rvm.io | bash -s stable))
      end
      execute("su - #{host.user} -c 'rvm use --autolibs=disable --default --install 2.1.1'")
    end
  end

  desc "Install redis nginx memcache git nodejs and upload conf"
  task :server => :as_root do
    on roles(:all) do |host|
      execute('apt-get install -y redis-server memcached nginx git-core nodejs')
      execute('service nginx start')
    end
  end

  desc "Install unicorn init script"
  task :unicorn_init_script => :as_root do
    on roles(:all) do |host|
      unicorn_template_path = File.expand_path('config/unicorn_init.sh.erb')
      unicorn_config_binding = OpenStruct.new({
        user: host.user,
        deploy_to: deploy_to,
        application: fetch(:application)
      }).instance_eval { binding }
      unicorn_config   = ERB.new(File.new(unicorn_template_path).read).result(unicorn_config_binding)
      upload! StringIO.new(unicorn_config), "/etc/init.d/unicorn_#{fetch(:application)}"
      execute("chmod 755 /etc/init.d/unicorn_#{fetch(:application)}")
      execute("update-rc.d unicorn_#{fetch(:application)} defaults")
    end
  end

  desc "Install resques init script"
  task :resque_init_script => :as_root do
    on roles(:all) do |host|
      resque_template_path = File.expand_path('config/resque_init.sh.erb')
      resque_config_binding = OpenStruct.new({
        user: host.user,
        deploy_to: deploy_to,
        application: fetch(:application)
      }).instance_eval { binding }
      resque_config   = ERB.new(File.new(resque_template_path).read).result(resque_config_binding)
      upload! StringIO.new(resque_config), "/etc/init.d/resque_#{fetch(:application)}"
      execute("chmod 755 /etc/init.d/resque_#{fetch(:application)}")
      execute("update-rc.d resque_#{fetch(:application)} defaults")
    end
  end

  desc "Install nginx conf"
  task :nginx_conf => :as_root do
    on roles(:all) do |host|
      config_binding = OpenStruct.new({
        deploy_to: deploy_to
      }).instance_eval { binding }
      config = ERB.new(File.new('config/nginx.conf.erb').read).result(config_binding)
      upload! StringIO.new(config), "/etc/nginx/sites-enabled/#{fetch(:application)}.conf"
      execute('service nginx reload')
    end
  end

  desc "Prepare deploy to"
  task :prepare_deploy_to => :as_root do
    on roles(:all) do |host|
      execute("mkdir -p #{deploy_to}")
      execute("chown #{host.user}:#{host.user} #{deploy_to}")
    end
  end
end

