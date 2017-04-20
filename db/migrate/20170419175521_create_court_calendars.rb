class CreateCourtCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :court_calendars do |t|
      t.datetime :start_at
      t.time :start_time
      t.date :start_date
      t.string :atty_name
      t.string :title
      t.timestamps
    end
  end
end
