class ScheduledCourtsController < ApplicationController
  before_action :authenticate_user!
  layout 'front'

  def index
    @q = CourtCalendar.where(atty_last_name: current_user.last_name.downcase, atty_first_name: current_user.first_name.downcase).ransack(params[:q])
    @q.sorts = ['start_date asc', 'start_time asc'] if @q.sorts.empty?
    @court_calendars = @q.result(distinct: true).page(params[:page]).per(15)
  end
end
