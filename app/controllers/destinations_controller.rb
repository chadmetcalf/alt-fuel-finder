class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
  end

  def fuel_stations
    binding.pry
    NrelService.new.find_fuel_stations
    redirect_to destinations_path
  end
end
