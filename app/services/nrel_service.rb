class NrelService
  def initialize(params:)
    # initialize the bare minimum to make the class viable
    # creating other classes should be done right when we need them
    @params = params
  end

  def stations
    @_stations ||= coordinates.map do |_k, v|
        # move a funky mashed up piece of information into
        # something meaningful as soon as possible
        closest_nrel_station(lat: v.split(',')[0],
                             long: v.split(',')[1],
                             fuel_type: @params['fuel_type'])
      end
  end

  private

  def coordinates
    # I recommend using a matcher that you have a little more control over
    # Finding stuff in strings is exactly what Regular Expressions are best at
    @_coordinates ||= @params.select{ |k| k.match(/^lat*/i) }
  end

  # These methods below are starting to clump up with the same required
  # information...that is a signal that they are ripe for a refactor into
  # their own object very soon.
  #
  # Since the lat & long represent the user's position when they are
  # looking fo the nearest station, I think that a Postion model makes
  # a lot of sense. Then Postion#closest_nrel_station would return an
  # NRelStation object
  def closest_nrel_station(lat:, long:, fuel_type:)
    # After the refcator this method might call:
    # Position.new(lat: '41.11496', long: '-101.71232')
    #         .closest_nrel_station(fuel_type: :electric)
    # => #<NRelStation id: "51672", name: "OGALLALA">
    nrel_stations_response = nrel_fuel_stations(lat: lat,
                                                long: long,
                                                fuel_type: fuel_type)
    parse(nrel_stations_response.body)[:fuel_stations].first
  end

  def nrel_fuel_stations(lat:, long:, fuel_type:)
    connection.get do |req|
      req.url 'nearest.json?'
      req.params['api_key'] = ENV['NREL_KEY']
      req.params['latitude'] = lat
      req.params['longitude'] = long
      req.params['fuel_type'] = fuel_type
      req.params['radius'] = 30
      req.params['limit'] = 1
    end
  rescue Faraday::ConnectionFailed
    # log the error
    # maybe try again or return a sensible fall back?
  end

  def connection
    @_connection ||= Faraday.new(url: nrel_api_uri) { |faraday| faraday.adapter Faraday.default_adapter }
  end

  def nrel_api_uri
    # Using URI object gives us a lot more robustness than a string
    URI('https://developer.nrel.gov/api/alt-fuel-stations/v1/')
  end

  def parse(body)
    JSON.parse(body, symbolize_names: true)
  end
end
