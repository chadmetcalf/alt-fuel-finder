require 'rails_helper'

describe 'nrel service' do
  context '#fetch_stations' do
    it 'returns a fuel station for each coordinate and fuel type' do
      VCR.use_cassette('nrel_service') do
        params = {
          'latLng0' => '41.11496,-101.71232', 'latLng1' => '40.821110000000004,-97.63129',
          'latLng2' => '41.541380000000004,-94.00112000000001',
          'latLng3' => '41.43824,-90.17155000000001',
          'latLng4' => '41.72204000000001,-86.24844', 'latLng5' => '41.334680000000006,-82.3807',
          'latLng6' => '42.65402,-78.96629', 'latLng7' => '43.13613,-75.26988',
          'latLng8' => '42.191500000000005,-71.85867', 'fuel_type' => 'ELEC'
        }

        subject = NrelService.new(params: params)

        stations  = subject.stations

        expect(stations.class).to eq(Array)
        expect(stations.count).to eq(9)

        expect(stations.first[:id]).to eq(51_672)
        expect(stations.first[:station_name]).to eq('OGALLALA')
        expect(stations.first[:access_days_time]).to eq('24 hours daily')
        expect(stations.first[:latitude]).to eq(41.1257932)
        expect(stations.first[:longitude]).to eq(-101.715413)

        expect(stations.last[:id]).to eq(45_875)
        expect(stations.last[:station_name]).to eq('Bertera Nissan')
        expect(stations.last[:access_days_time]).to eq(nil)
        expect(stations.last[:latitude]).to eq(42.1828905)
        expect(stations.last[:longitude]).to eq(-71.8513063)
      end
    end
  end
end
