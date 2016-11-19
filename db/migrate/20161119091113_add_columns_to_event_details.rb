class AddColumnsToEventDetails < ActiveRecord::Migration[5.0]
  def change
    rename_column  :event_details, :address, :location
    add_column     :event_details, :latitude, :float
    add_column     :event_details, :longitude, :float
  end
end
