class AddUserToFuelStations < ActiveRecord::Migration[5.0]
  def change
    add_reference :fuel_stations, :user, foreign_key: true
  end
end
