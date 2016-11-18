class CreateBandSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :band_songs do |t|
      t.string :song_name
      t.integer  :band_id
      

      t.timestamps
    end
  end
end
