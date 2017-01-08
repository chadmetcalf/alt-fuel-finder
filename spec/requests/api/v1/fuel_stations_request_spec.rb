require 'rails_helper'

describe "fuel stations endpoints" do
  context "GET /fuel_stations" do
    it "returns fuel stations for the specified query params" do
      get "/api/v1/fuel_stations?lat=39.7392&lng=-104.9903"
    end
  end
end
