class Api::RequestsController < ApplicationController
  before_action :authenticate_request!

  def index
    page = params[:page]
    requests = @current_user.requests.order(created_at: :desc).page(page).per(3)
    render json: {requests: requests, count: @current_user.requests.count}
  end

  def create
    params[:user_id] = @current_user.id
    request = Request.create(request_params)

    render json: (attorneys request)
  end


  private

  def attorneys request
    # attorneys = CourtCalendar.where('lower(atty_name) = ? and start_date = ? and start_time = ? ', params[:court_name].downcase, params[:date], params[:time]).group(:atty_name)
    attorneys = CourtCalendar.select('DISTINCT ON (atty_name) *').where(atty_name: params[:court_name].downcase, start_date: params[:date], start_time: params[:time])

    message = request.message
    attorneys.each do |atty|
      user = User.find_by(name: atty.atty_name.downcase)
      unless user.nil?
        request_history = request.request_histories.build(
          user_id: @current_user.id,
          message: message,
          receive_id: user.id,
          court_title: atty.title,
          court_date: atty.start_date,
          court_time: atty.start_time)

        if request_history.save
          send_sms user, message, request_history
        end
      end
    end
    request.request_histories
  end
  def request_params
    params.permit(:court_name, :date, :time, :hearing, :notes, :court, :user_id)
  end
end
