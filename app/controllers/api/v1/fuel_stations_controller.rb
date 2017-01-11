class Api::V1::FuelStationsController < ApplicationController
  def index
    parameters = params.select { |k,v| k.include?("latLng") }
    fuel = params["fuel_type"]
    stations = []
    parameters.each do |k, v|
      lat = v.split(",")[0]
      lng = v.split(",")[1]
      response = Faraday.get("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['NREL_KEY']}&latitude=#{lat}&longitude=#{lng}&fuel_type=#{fuel}&radius=30.0&limit=1")
      parsed = JSON.parse(response.body, symbolize_names: true)
      stations << parsed[:fuel_stations].first
    end
    render json: stations
  end
end
