class ProfilesController < ApplicationController
  before_action :authenticate_user!
  layout 'front'

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(profile_params)
      sign_in(@user, :bypass => true)
      redirect_to edit_profiles_path, notice: 'Profile has been updated successfully.'
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
