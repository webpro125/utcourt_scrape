class Admin::RequestsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
    @request_histories = @request.request_histories.order(created_at: :desc)
  end
end
