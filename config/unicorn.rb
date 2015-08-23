# root = "/home/deployer/apps/broker_mgr/current"
# working_directory root
# pid "#{root}/tmp/pids/unicorn.pid"
# stderr_path "#{root}/log/unicorn.log"
# stdout_path "#{root}/log/unicorn.log"
#
# listen "/tmp/unicorn.broker_mgr.sock"
# worker_processes 8
# timeout 120
#

APP_ROOT = "/home/deployer/apps/broker_mgr/current"#File.expand_path(File.dirname(File.dirname(__FILE__)))

ENV['BUNDLE_GEMFILE'] = File.expand_path('../Gemfile', File.dirname(__FILE__))
require 'bundler/setup'

worker_processes 8
working_directory APP_ROOT
preload_app true
timeout 30
listen APP_ROOT + "/tmp/pids/unicorn.sock", :backlog => 64
pid APP_ROOT + "/tmp/pids/unicorn.pid"

stderr_path APP_ROOT + "/log/unicorn.stderr.log"
stdout_path APP_ROOT + "/log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = Rails.root + '/tmp/pids/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Old master already dead"
    end
  end
end

# load the scheduler init script
require APP_ROOT+'/lib/scheduler'
# path to the scheduler pid file
scheduler_pid_file = File.join(APP_ROOT, "tmp/pids/scheduler.pid").to_s

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
  child_pid = server.config[:pid].sub('.pid', ".#{worker.nr}.pid")
  system("echo #{Process.pid} > #{child_pid}")

  # run scheduler initialization
  # Scheduler::start_unless_running scheduler_pid_file
end
