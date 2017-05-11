class Api::RequestsController < ApplicationController
  before_action :authenticate_request!

  def create
    Request.create(request_params)
    render json: attorneys
  end


  private

  def attorneys
    CourtCalendar.where('lower(atty_name) = ?', params[:court_name].downcase)

  end
  def request_params
    params.permit(:court_name, :date, :time, :hearing, :notes, :court)
  end
end
