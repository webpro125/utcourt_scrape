class AddBarNumberToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bar_number, :string
    add_index :users, :first_name
  end
end
