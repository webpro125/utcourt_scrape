class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin!

  def index
    params[:q][:atty_name_eq] = params[:q][:atty_name_eq].downcase if params[:q].present?

    @q = CourtCalendar.ransack(params[:q])
    @court_calendars = @q.result.page(params[:page]).per(10) if params[:q].present?

  end
end
