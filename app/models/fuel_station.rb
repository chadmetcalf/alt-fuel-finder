class FuelStation < ApplicationRecord
  belongs_to :itinerary

  geocoded_by :address
  after_validation :geocode
end
