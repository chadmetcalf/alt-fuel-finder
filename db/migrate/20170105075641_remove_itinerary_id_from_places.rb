class RemoveItineraryIdFromPlaces < ActiveRecord::Migration[5.0]
  def change
    remove_column :places, :itinerary_id
  end
end
