class Api::UsersController < ApplicationController
  before_action :authenticate_request!

  def user_info
    @user = User.all
    render json: @user
  end
end
