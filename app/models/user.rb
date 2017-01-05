class User < ApplicationRecord
  has_many :places
  has_many :fuel_stations

  has_secure_password
  validates_confirmation_of :password

end
