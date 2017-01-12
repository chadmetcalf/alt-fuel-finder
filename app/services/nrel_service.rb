class NrelService
  attr_reader :conn, :stations

  def initialize
    @conn = connection
    @stations = [];
  end

  def fetch_stations(params)
    coordinates = extract_coordinates(params)
    coordinates.each { |k, v| fetch_a_station(v, params["fuel_type"]) }
    return stations
  end

  private

    def connection
      base_url = "https://developer.nrel.gov/api/alt-fuel-stations/v1/"
      Faraday.new(url: base_url) { |faraday|  faraday.adapter Faraday.default_adapter }
    end

    def extract_coordinates(params)
      params.select { |k,v| k.include?("latLng") }
    end

    def fetch_a_station(lat_long, fuel_type)
      response = conn.get do |req|
        req.url "nearest.json?"
        req.params["api_key"] = ENV['NREL_KEY']
        req.params["latitude"] = lat_long.split(",")[0]
        req.params["longitude"] = lat_long.split(",")[1]
        req.params["fuel_type"] = fuel_type
        req.params["radius"] = 30
        req.params["limit"] = 1
      end
      stations << parse(response.body)
    end

    def parse(body)
      JSON.parse(body, symbolize_names: true)[:fuel_stations].first
    end
end
