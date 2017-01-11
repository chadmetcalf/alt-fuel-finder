require 'rails_helper'

describe "fuel stations endpoints" do
  context "GET /fuel_stations" do
    it "returns an electric fuel station for every 200 mile interval between Denver and Boston" do
      VCR.use_cassette("internal_api") do

        params = {
          "latLng0"=>"41.11496,-101.71232", "latLng1"=>"40.821110000000004,-97.63129",
          "latLng2"=>"41.541380000000004,-94.00112000000001",
          "latLng3"=>"41.43824,-90.17155000000001",
          "latLng4"=>"41.72204000000001,-86.24844", "latLng5"=>"41.334680000000006,-82.3807",
          "latLng6"=>"42.65402,-78.96629", "latLng7"=>"43.13613,-75.26988",
          "latLng8"=>"42.191500000000005,-71.85867", "fuel_type"=>"ELEC"
        }

        get "/api/v1/fuel_stations?", params

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_success
        expect(result.class).to eq(Array)
        expect(result.count).to eq(9)

        expect(result.first[:id]).to eq(33279)
        expect(result.first[:station_name]).to eq("Western Convenience Store")
        expect(result.first[:access_days_time]).to eq("24 hours daily")
        expect(result.first[:latitude]).to eq(41.1250917)
        expect(result.first[:longitude]).to eq(-101.7160397)

        expect(result.last[:id]).to eq(45875)
        expect(result.last[:station_name]).to eq("Bertera Nissan")
        expect(result.last[:access_days_time]).to eq(nil)
        expect(result.last[:latitude]).to eq(42.1828905)
        expect(result.last[:longitude]).to eq(-71.8513063)
      end
    end
  end
end
