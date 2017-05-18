class AddReceiveIdRequestHistories < ActiveRecord::Migration[5.0]
  def change
    add_reference :request_histories, :receive, index: true
  end
end
