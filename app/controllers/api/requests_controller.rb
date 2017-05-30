class Api::RequestsController < ApplicationController
  before_action :authenticate_request!

  def index
    page = params[:page]
    requests = @current_user.requests.order(created_at: :desc).page(page).per(3)
    render json: {requests: requests, count: @current_user.requests.count}
  end

  def create
    params[:user_id] = @current_user.id
    court_location = CourtLocation.find(params[:court_location].to_i)
    params[:court_location_id] = params[:court_location].to_i
    params[:court_location] = court_location.name
    request = Request.create(request_params)

    render json: (attorneys request)
  end


  private

  def attorneys request
    # attorneys = CourtCalendar.where('lower(atty_name) = ? and start_date = ? and start_time = ? ', params[:court_name].downcase, params[:date], params[:time]).group(:atty_name)
    start = params[:time].to_time - 15*60
    ending = params[:time].to_time + 15*60
    attorneys = CourtCalendar
              .where(court_location_id: params[:court_location_id], start_date: params[:date])
              .where('start_time::time >= ? and start_time <= ?', start.strftime('%H:%M:%S'), ending.strftime('%H:%M:%S'))

    message = request.message
    puts '------------ attorney -----------'
    puts attorneys.count
    puts '----------- end ------------'
    attorneys.each do |atty|
      user = User.find_by(last_name: atty.atty_last_name.downcase)
      unless user.nil?
        request_history = request.request_histories.build(
          user_id: @current_user.id,
          message: message,
          receive_id: user.id,
          court_title: atty.court_location.name,
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
    params.permit(:client_name, :date, :time, :hearing, :notes, :court_location, :user_id)
  end
end
