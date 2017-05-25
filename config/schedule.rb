# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
# every 1.week, :at => '12pm' do
#   runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
# end
every 10.minute do
# every 1.week, :at => '4:30 am' do
#   rake 'pdf:download'
#   rake "calendar:update_calendar"
#   runner 'Rake::Task["first:task"].enhance do
#     Rake::Task["calendar:update_calendar"].invoke
#   end'
end
# Learn more: http://github.com/javan/whenever
