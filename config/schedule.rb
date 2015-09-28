# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
# RAILS_ROOT = File.dirname(__FILE__) + '/..'
# Example:
#
# set :output, {:standard => nil}
#
every 2.hours do
  runner "Schedule.task_user"
end

every 1.day do
  runner "Schedule.task_branches"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
