class Api::V1::FuelStationsController < ApplicationController
  def index
    render json: NrelService.new.fetch_stations(params)
  end
end
