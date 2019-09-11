module Api
  class RequestHistoriesController < ApplicationController
    before_action :authenticate_request!

    def index
      page = params[:page]
      histories = RequestHistory.where(receive_id: @current_user.id).order(created_at: :desc)
      render json: {histories: histories.page(page).per(3).to_json(include: :user), count: histories.count}
    end
  end
end
