class AddNameToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name,    :string,   limit: 128
    change_column :users, :first_name,    :string,   null: true, limit: 64
    change_column :users, :last_name,    :string,   null: true, limit: 64
    add_column :users, :approved, :boolean, default: false
  end
end
