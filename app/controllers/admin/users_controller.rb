class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # @user.skip_confirmation!
    if @user.save
      # UserMailer.user_created(@user).deliver
      redirect_to admin_users_path, notice: 'User has been created successfully!'
    else render :new
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: 'User has been Updated successfully.'
    else render :edit
    end
  end

  def approve
    @user = User.find(params[:user_id])
    if @user.update_attributes(approved: true)
      redirect_to admin_users_path, notice: 'User has been approved successfully.'
    else render :index
    end
  end

  def disapprove
    @user = User.find(params[:user_id])
    if @user.update_attributes(approved: false)
      redirect_to admin_users_path, notice: 'User has been disapproved successfully.'
    else render :index
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'User has been deleted successfully.'
    else render :index
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone)
  end
end
