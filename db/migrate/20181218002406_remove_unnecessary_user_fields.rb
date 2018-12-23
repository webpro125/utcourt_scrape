class RemoveUnnecessaryUserFields < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :username
    remove_column :users, :name
    add_column :users, :middle_name, :string, null: false, default: ''
  end
end
