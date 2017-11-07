require File.expand_path('../config/environment', __dir__)
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
# every 30.minute do
every 1.days, :at => '4:30 am' do
  rake 'calendar:download'
  # rake "calendar:update_calendar"
end

if ActiveSupport::TimeZone["MST"].present?
  Time.zone = "MST"
else Time.zone = "MDT" end

# every 1.day, :at => Time.zone.parse('8:00 am').utc do
#   rake 'calendar:notify_today_court'
# end
#
# every 1.day, :at => Time.zone.parse('12:00').utc do
#   rake 'calendar:notify_today_court'
# end

every 5.minute do
  rake 'calendar:notify_today_court'
end
# Learn more: http://github.com/javan/whenever
