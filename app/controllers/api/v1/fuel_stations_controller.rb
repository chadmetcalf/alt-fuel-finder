class Api::V1::FuelStationsController < ApplicationController
  def index
    nrel_service = NrelService.new(params: params)

    render json: nrel_service.stations
end
