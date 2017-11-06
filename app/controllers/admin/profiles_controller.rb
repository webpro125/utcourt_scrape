class Admin::ProfilesController < ApplicationController
  before_action :authenticate_admin!

  def edit
    @user = current_admin
  end

  def update
    @user = current_admin

    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @user.update_attributes(profile_params)
      sign_in(@user, :bypass => true)
      redirect_to edit_admin_profiles_path, notice: 'Profile has been updated successfully.'
    else
      render :edit
    end
  end

  def scheduled_courts
    @q = CourtCalendar.where(atty_last_name: 'stone', atty_first_name: 'edward j').ransack(params[:q])
    @q.sorts = ['start_date asc', 'start_time asc'] if @q.sorts.empty?
    @court_calendars = @q.result.page(params[:page]).per(15)
  end

  private

  def profile_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
