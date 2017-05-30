class Api::AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if !user.nil? && user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def register_user

    user = User.new(user_params)
    if user.save
      render json: payload(user)
    else
      render json: {errors: user.errors.full_messages}, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
        auth_token: JsonWebToken.encode({user_id: user.id}),
        user: {id: user.id, email: user.email, first_name: user.first_name, last_name: user.last_name, phone: user.phone}
    }
  end

  def user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone)
  end
end
