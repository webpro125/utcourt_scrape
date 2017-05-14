class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  attr_reader :current_user


  def send_sms user, message
    if user.approved?
      to_phone = user.phone.to_s
      if to_phone[0] == "0"
        to_phone.sub!("0", '')
      end
      to_number = '+1' + to_phone
      begin
        twilio_client.messages.create(
            to: to_number,
            from: ENV['TWILIO_PHONE_NUMBER'],
            body: message
        )
      rescue Twilio::REST::RequestError => e
        puts e.message
      end

    else
      true
    end
  end

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private
  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
on