class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string  :date
      t.integer :event_id
      t.integer :user_id
    end
  end
end
