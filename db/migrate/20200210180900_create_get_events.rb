class CreateGetEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :get_events do |t|
      t.string :title
      t.string :category
      t.string :event_id_num
      t.string :description
    end
  end
end
