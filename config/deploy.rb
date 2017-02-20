require "bundler/capistrano"
require "delayed/recipes"

server "192.168.15.136", :web, :app, :db, primary: true

set :ssh_options, {
   config: false
}

# set :rbenv_ruby_version, "1.9.3-p385"
set :application, "broker_mgr"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:brokermgrteam/#{application}.git"
set :branch, "master"

set :rails_env, "production" #added for delayed job
set :whenever_command, "bundle exec whenever"
set :whenever_environment, "production"
require "whenever/capistrano"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

before "deploy:restart", "delayed_job:stop"
after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      put File.read("config/config.yml"), "#{shared_path}/config/config.yml"
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/config.yml"), "#{shared_path}/config/config.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

# namespace :delayed_job do
#     desc "Restart the delayed_job process"
#     task :restart, :roles => :app do
#         run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job restart"
#     end
# end
