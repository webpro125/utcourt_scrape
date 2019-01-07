class UserMailer < ApplicationMailer
  def notify_today_court email
    @user = User.where(email: 'edward@stonelawfirm.net').first
    @court_calendars = CourtCalendar.where(atty_last_name: 'stone', atty_first_name: 'edward j', start_date: Date.today).order(start_time: :asc)
    mail(to: email, from: 'no-reply@firm.net', subect: 'Today Scheduled Courts')
    # mail(to: 'edward@stonelawfirm.net', from: 'edward@stonelawfirm.net', subect: 'Today Scheduled Courts')
  end

  def notify_user_registered user
    @user = user
    mail(to: 'sokomheng89@gmail.com', from: 'no-reply@firm.net', subject: 'One user is waiting for Approvement' )
  end
end
