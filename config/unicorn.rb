APP_PATH = File.expand_path(File.expand_path(File.dirname(__FILE__)) + "/../")

worker_processes 2
working_directory APP_PATH

listen "/tmp/unicorn.campo.sock", :backlog => 64
timeout 30

pid "#{APP_PATH}/tmp/pids/unicorn.pid"
stderr_path "#{APP_PATH}/log/unicorn.stderr.log"
stdout_path "#{APP_PATH}/log/unicorn.stdout.log"

preload_app true

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
