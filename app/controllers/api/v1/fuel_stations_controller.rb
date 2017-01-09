class Api::V1::FuelStationsController < ApplicationController
  def index
    lat = params[:lat]
    lng = params[:lng]
    fuel = params[:fuel_type]
    response = Faraday.get("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['NREL_KEY']}&latitude=#{lat}&longitude=#{lng}&fuel_type=#{fuel}&radius=15.0")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:fuel_stations]
    binding.pry
  end
end
