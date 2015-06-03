root = "/home/deployer/apps/broker_mgr/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.broker_mgr.sock"
worker_processes 16
timeout 300
