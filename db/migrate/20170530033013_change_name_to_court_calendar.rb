class ChangeNameToCourtCalendar < ActiveRecord::Migration[5.0]
  def change
    add_column :court_calendars, :atty_first_name, :string
    add_column :court_calendars, :atty_last_name, :string
    remove_column :court_calendars, :atty_name
  end
end
