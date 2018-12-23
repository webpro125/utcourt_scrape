Module Api do
class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  attr_reader :current_user


  def send_sms user, message, request_history
    if user.approved?
      to_phone = user.phone.to_s
      to_phone.sub!("0", '') if to_phone[0] == "0"
      to_number = ENV['COUNTRY_CODE'] + to_phone
      begin
        twilio_client.messages.create(
            to: to_number,
            from: ENV['TWILIO_PHONE_NUMBER'],
            body: message
        )
        request_history.update_attributes(is_sent: true)
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

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || signed_in_root_path(resource)
  end

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
end