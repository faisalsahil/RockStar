class CreateEventDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :event_details do |t|
      t.string :institute_name
      t.string :institute_type
      t.string :address
      t.integer  :event_id

      t.timestamps
    end
  end
end
