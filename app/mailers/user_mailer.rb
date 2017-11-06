class UserMailer < ApplicationMailer
  def notify_today_court
    @user = User.where(email: 'edward@stonelawfirm.net').first
    @court_calendars = CourtCalendar.where(atty_last_name: 'stone', atty_first_name: 'edward j', start_date: Date.today)
    mail(to: 'edward@stonelawfirm.net', from: 'edward@stonelawfirm.net', subect: 'Today Scheduled Courts')
  end
end
