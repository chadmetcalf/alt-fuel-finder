class Itinerary < ApplicationRecord
  belongs_to :user
  has_many :places
  has_many :fuel_stations
end
