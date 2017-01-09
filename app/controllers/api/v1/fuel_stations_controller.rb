class Api::V1::FuelStationsController < ApplicationController
  def index
    parameters = params.select { |k,v| k.include?("coords") }
    fuel = params["fuel_type"]
    fuel_stations = parameters.map do |k, v|
      lat = v.split(",")[0]
      lng = v.split(",")[1]
      response = Faraday.get("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['NREL_KEY']}&latitude=#{lat}&longitude=#{lng}&fuel_type=#{fuel}&radius=15.0")
      parsed = JSON.parse(response.body, symbolize_names: true)
      parsed_data = parsed[:fuel_stations]
    end
    render json: fuel_stations
  end
end
