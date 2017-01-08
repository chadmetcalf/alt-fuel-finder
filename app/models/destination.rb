class Destination < ApplicationRecord

  geocoded_by :address
  after_validation :geocode

  def self.populate(raw_stations)
    raw_stations["fuel_stations"].each do |station|
      # binding.pry
      Destination.create!(title: station["station_name"], address: station["zip"])
    end
  end
end
