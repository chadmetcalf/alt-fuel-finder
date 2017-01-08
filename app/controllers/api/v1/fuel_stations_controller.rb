class Api::V1::FuelStationsController < ApplicationController
  def index
    lat = params[:lat]
    lng = params[:lng]

    Faraday.get("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['NREL_API']}&latitude=#{lat}&longitude=#{lng}&radius=15.0")
    parsed = JSON.parse(response.body, symbolize_names: true)
    binding.pry
  end
end
