# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'broker_mgr'
set :repo_url, 'git@github.com:brokermgrteam/broker_mgr.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
set :default_env, { rvm_bin_path: '~/.rvm/bin' }

# Default value for keep_releases is 5
set :keep_releases, 10

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :passenger_rvm_ruby_version, "2.3.1"
set :passenger_restart_with_sudo, true
set :passenger_restart_with_touch, true

# Number of delayed_job workers
# default value: 1
set :delayed_job_workers, 2

# String to be prefixed to worker process names
# This feature allows a prefix name to be placed in front of the process.
# For example:  reports/delayed_job.0  instead of just delayed_job.0
set :delayed_job_prefix, 'reports'

# Delayed_job queue or queues
# Set the --queue or --queues option to work from a particular queue.
# default value: nil
set :delayed_job_queues, ['mailer','tracking']

# Specify different pools
# You can use this option multiple times to start different numbers of workers
# for different queues.
# NOTE: When using delayed_job_pools, the settings for delayed_job_workers and
# delayed_job_queues are ignored.
# default value: nil
#
# Single pool of 3 workers looking at all queues: (when alone, '*' is a
# special case meaning any queue)
# set :delayed_job_pools, { '*' => 3 }
# set :delayed_job_pools, { '' => 3 }
# set :delayed_job_pools, { nil => 3 }
#
# Several queues, some with their own dedicated pools: (symbol keys will be
# converted to strings)
# set :delayed_job_pools, {
#     :mailer => 2,    # 2 workers looking only at the 'mailer' queue
#     :tracking => 1,  # 1 worker exclusively for the 'tracking' queue
#     :* => 2          # 2 on any queue (including 'mailer' and 'tracking')
# }
#
# Several workers each handling one or more queues:
# set :delayed_job_pools, {
#     'high_priority' => 1,                # one just for the important stuff
#     'high_priority,*' => 1,              # never blocked by low_priority jobs
#     'high_priority,*,low_priority' => 1, # works on whatever is available
#     '*,low_priority' => 1,  # high_priority doesn't starve the little guys
#   }
# Identification is assigned in order 0..3.
# Note that the '*' in this case is actually a queue with that name and does
# not mean any queue as it is not used alone, but alongside other queues.

# Set the roles where the delayed_job process should be started
# default value: :app
set :delayed_job_roles, [:app, :background]

# Set the location of the delayed_job executable
# Can be relative to the release_path or absolute
# default value: 'bin'
set :delayed_job_bin_path, 'script' # for rails 3.x

# To pass the `-m` option to the delayed_job executable which will cause each
# worker to be monitored when daemonized.
# set :delayed_job_monitor, true

### Set the location of the delayed_job.log logfile
# default value: "#{Rails.root}/log" or "#{Dir.pwd}/log"
# set :delayed_log_dir, 'path_to_log_dir'

### Set the location of the delayed_job pid file(s)
# default value: "#{Rails.root}/tmp/pids" or "#{Dir.pwd}/tmp/pids"
# set :delayed_job_pid_dir, 'path_to_pid_dir'
set :delayed_job_pid_dir, '/tmp'

after 'deploy:published', 'delayed_job:restart' do
    invoke 'delayed_job:restart'
end
