class EliminateUnnecessaryModels < ActiveRecord::Migration[5.0]
  def change
    drop_table :fuel_stations
    drop_table :itineraries
    drop_table :places
  end
end
