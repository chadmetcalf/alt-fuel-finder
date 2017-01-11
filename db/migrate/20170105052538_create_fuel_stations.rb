class CreateFuelStations < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_stations do |t|
      t.string :latitude
      t.string :longitude
      t.string :address
      t.string :title
      t.string :description
      t.references :itinerary, foreign_key: true

      t.timestamps
    end
  end
end
