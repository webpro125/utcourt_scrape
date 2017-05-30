class CreateCourtLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :court_locations do |t|
      t.string :name, unique: true
      t.timestamps
    end
    add_reference :court_calendars, :court_location, index: true
  end
end
