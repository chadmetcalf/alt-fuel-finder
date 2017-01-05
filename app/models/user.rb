class User < ApplicationRecord
  has_many :itineraries

  has_secure_password
  validates_confirmation_of :password
end
