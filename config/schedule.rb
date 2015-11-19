# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# RAILS_ROOT = File.dirname(__FILE__) + '/..'
# Example:
#
# set :output, {:standard => nil}
#
every :reboot do
  command "source ~/.bashrc"
  command "cd /home/deployer/apps/broker_mgr/current && RAILS_ENV=production script/delayed_job start"
end

every 3.hours do
  command "cd /home/deployer/apps/broker_mgr/current && RAILS_ENV=production script/delayed_job restart"
end

every 6.hours do
  runner "Schedule.task_user", :output => {:error => 'error.log', :standard => 'cron.log'}
end

every 12.hours do
  runner "Schedule.task_exam", :output => {:error => 'error.log', :standard => 'cron.log'}
end

every 1.day do
  runner "Schedule.task_branches"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
