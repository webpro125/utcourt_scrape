class AddJudgeToCalendar < ActiveRecord::Migration[5.0]
  def change
    add_column :court_calendars, :judge, :string
  end
end
