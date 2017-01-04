class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
    @hash = Gmaps4rails.build_markers(@destinations) do |destination, marker|
      marker.lat destination.latitude
      marker.lng destination.longitude
      marker.infowindow destination.description
      marker.json({title: destination.title})
    end
  end
end
