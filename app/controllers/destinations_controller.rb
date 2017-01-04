class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
    # @hash = Gmaps4rails.build_markers(@destinations) do |destination, marker|
    #   marker.lat destination.latitude
    #   marker.lng destination.longitude
    #   marker.infowindow destination.description
    #   marker.json({title: destination.title})
    # end
  end

  def fuel_stations
    NrelService.new.find_fuel_stations
    redirect_to destinations_path
  end
end
