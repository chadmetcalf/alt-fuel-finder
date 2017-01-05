class NrelService
  attr_reader :conn

  def initialize
    @conn = connection
  end

  def find_fuel_stations(user)
    destination_1 = user.places.first.longitude.to_s + " " + user.places.first.latitude.to_s
    destination_2 = user.places.last.longitude.to_s + " " + user.places.last.latitude.to_s
    fuel_type = "BD"
    response = conn.get("nearby-route.json?api_key=#{ENV['nrel_key']}&route=LINESTRING(#{destination_1}, #{destination_2})&fuel_type=#{fuel_type}")
    parsed = JSON.parse(response.body)
    parsed.map do |station|
      user.fuel_stations.create!(title: station["station_name"], address: station["zip"])
    end
  end

  private

    def connection
      Faraday.new(url: "https://developer.nrel.gov/api/alt-fuel-stations/v1") do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end
end
