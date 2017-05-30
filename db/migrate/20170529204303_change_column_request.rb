class ChangeColumnRequest < ActiveRecord::Migration[5.0]
  def change
    rename_column :requests, :court, :court_location
    rename_column :requests, :court_name, :client_name
  end
end
