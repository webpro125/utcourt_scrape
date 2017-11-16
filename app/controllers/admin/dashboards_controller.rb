class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def index
    params[:q][:atty_last_name_eq] = params[:q][:atty_last_name_eq].downcase if params[:q].present? && params[:q][:atty_last_name_eq].present?

    @q = CourtCalendar.ransack(params[:q])
    @q.sorts = ['start_date asc', 'start_time asc'] if @q.sorts.empty?
    @court_calendars = @q.result.page(params[:page]).per(15)

  end
end
