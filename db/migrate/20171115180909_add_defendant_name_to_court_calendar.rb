class AddDefendantNameToCourtCalendar < ActiveRecord::Migration[5.0]
  def change
    add_column :court_calendars, :defendant_name, :string
  end
end
