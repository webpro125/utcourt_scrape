class CreateRequestHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :request_histories do |t|
      t.references :request, index: true
      t.references :user, index: true
      t.text :message
      t.timestamps
    end
  end
end
