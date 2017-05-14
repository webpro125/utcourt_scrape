class AddIsSentRequestHistories < ActiveRecord::Migration[5.0]
  def change
    add_column :request_histories, :is_sent, :boolean, default: false
    add_reference :request_histories, :court_calendar, index: true
    add_index :court_calendars, :atty_name
    add_index :users, :name
  end
end
