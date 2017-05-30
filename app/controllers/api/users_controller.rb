class Api::UsersController < ApplicationController
  before_action :authenticate_request!

  def user_info
    @user = User.all
    render json: @user
  end

  def update
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    if @current_user.update_attributes(user_params)
      render json: @current_user
    else render json: @current_user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def court_locations
    render json: CourtLocation.all
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone)
  end
end
