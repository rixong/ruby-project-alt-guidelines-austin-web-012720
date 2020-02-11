class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :date
      t.string :category
      t.string :event_id_num
      t.string :description
    end
  end
end
