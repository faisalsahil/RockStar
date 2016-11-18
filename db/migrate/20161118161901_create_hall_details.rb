class CreateHallDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :hall_details do |t|
      t.string :attachment_url
      t.string :thumbnail_url
      t.integer  :event_hall_id

      t.timestamps
    end
  end
end
