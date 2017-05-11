class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :court_name
      t.date :date
      t.time :time
      t.string :court
      t.string :hearing
      t.text :notes
      t.integer :range
      t.references :user
      t.timestamps
    end
  end
end
