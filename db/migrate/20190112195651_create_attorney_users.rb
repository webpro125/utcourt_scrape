class CreateAttorneyUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :attorney_users do |t|
      t.string :first_name, null: false, index: true
      t.string :last_name, null: false, index: true
      t.timestamps
    end
  end
end
