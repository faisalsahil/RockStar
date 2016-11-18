class CreateBands < ActiveRecord::Migration[5.0]
  def change
    create_table :bands do |t|
      t.string :band_name
      t.integer  :event_id

      t.timestamps
    end
  end
end
