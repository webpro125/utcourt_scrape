class AddColumnsRequestHistory < ActiveRecord::Migration[5.0]
  def change
    remove_reference :request_histories, :court_calendar
    add_column :request_histories, :court_title, :string
    add_column :request_histories, :court_date, :string
    add_column :request_histories, :court_time, :string
  end
end
