class MapService
  def self.get_location(location)
    # binding.pry
    loc = MapService.get_data("geocoding/v1/address?key=#{ENV['MAP_KEY']}&location=#{location}")
    
    loc[:results].first[:locations].first[:latLng]
  end
  
  def self.get_trip(origin, destination)
    # binding.pry
    trip = MapService.get_data("/directions/v2/route?key=#{ENV['MAP_KEY']}&from=#{origin}&to=#{destination}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")#[:route]
    #, params: origin: origin, destination: destination)#[:route]
    
    # binding.pry
    
    # 
  end
  
  def self.get_data(url)
    response = conn.get(url)
    
    # trip = 
    JSON.parse(response.body, symbolize_names: true)
    # binding.pry
  end
  
  private
  
  def self.conn
    Faraday.new(
      url: "https://www.mapquestapi.com/", #geocoding/v1/address
      params: {
        key: ENV['MAP_KEY'],
        headers: { 'Content-Type' => 'application/json' }
      }
    )
  end
end