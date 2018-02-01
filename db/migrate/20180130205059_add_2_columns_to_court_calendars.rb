class Add2ColumnsToCourtCalendars < ActiveRecord::Migration[5.0]
  def change
    add_column :court_calendars, :hearing_type, :string
    add_column :court_calendars, :case_number, :string
  end
end
