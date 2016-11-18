class CreateBandMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :band_members do |t|
      t.string :member_name
      t.string :member_type
      t.integer  :band_id

      t.timestamps
    end
  end
end
