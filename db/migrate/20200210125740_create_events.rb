class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :category
      t.date :date
      t.string :venue
      t.string :ticket_info
    end
  end
end
