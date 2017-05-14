class Api::RequestsController < ApplicationController
  before_action :authenticate_request!

  def create
    request = Request.create(request_params)

    render json: (attorneys request)
  end


  private

  def attorneys request
    attorneys = CourtCalendar.where('lower(atty_name) = ?', params[:court_name].downcase)
    message = 'test message'
    attorneys.each do |atty|
      user = User.find_by(name: atty.name)
      unless user.nil?
        request_history = request.request_histories.build(
          user_id: @current_user.id,
          message: message,
          court_calendar_id: atty.id)

        if request_history.save
          send_sms user, message, request_history
        end
      end
    end
  end
  def request_params
    params.permit(:court_name, :date, :time, :hearing, :notes, :court)
  end
end
