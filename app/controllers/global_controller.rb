class GlobalController < ApplicationController

  def user_autocomplete
    search = params[:q]
    @users = AttorneyUser.select("first_name, last_name, CONCAT(first_name, ' ', last_name) as value, id").where('lower(first_name) LIKE ?', "%#{search.downcase}%").limit(15)
    render json: @users
  end
end