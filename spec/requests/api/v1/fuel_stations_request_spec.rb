require 'rails_helper'

describe "fuel stations endpoints" do
  context "GET /fuel_stations" do
    it "returns electric fuel stations for 200 mile intervals between Denver and Boston" do

      params = {"coords0"=>"41.11496,-101.71232", "coords1"=>"40.821110000000004,-97.63129", "coords2"=>"41.541380000000004,-94.00112000000001", "coords3"=>"41.43824,-90.17155000000001", "coords4"=>"41.72204000000001,-86.24844", "coords5"=>"41.334680000000006,-82.3807", "coords6"=>"42.65402,-78.96629", "coords7"=>"43.13613,-75.26988", "coords8"=>"42.191500000000005,-71.85867", "fuel_type"=>"ELEC"}

      get "/api/v1/fuel_stations?", params

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(result.class).to eq(Array)
      expect(result.count).to eq(9)
      binding.pry
      expect(result.first[:station_name]).to eq("OGALLALA")
      expect(result.first[:latitude]).to eq(41.1257932)
      expect(result.first[:longitude]).to eq(41.1257932)
      expect(result.first[:access_days_time]).to eq("24 hours daily")


      expect(result.last[:station_name]).to eq("Bertera Nissan")
      expect(result.last[:latitude]).to eq(42.1828905)
      expect(result.last[:longitude]).to eq(-71.8513063)
      expect(result.last[:access_days_time]).to eq(nil)
    end
  end
end
