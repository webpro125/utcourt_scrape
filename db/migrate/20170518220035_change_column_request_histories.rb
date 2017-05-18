class ChangeColumnRequestHistories < ActiveRecord::Migration[5.0]
  def change
    change_column :request_histories, :court_date, 'date USING CAST(court_date AS date)'
    change_column :request_histories, :court_time, 'time USING CAST(court_time AS time)'
  end
end
