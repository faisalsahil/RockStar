class CreateEventHalls < ActiveRecord::Migration[5.0]
  def change
    create_table :event_halls do |t|
      t.string :hall_name
      t.integer  :event_id
      t.timestamps
    end
  end
end
