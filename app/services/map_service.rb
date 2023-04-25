class MapService
  def self.get_location(location)
    loc = MapService.get_data("geocoding/v1/address?key=#{ENV['MAP_KEY']}&location=#{location}")
    
    loc[:results].first[:locations].first[:latLng]
  end
  
  def self.get_data(url)
    response = conn.get(url)
    
    JSON.parse(response.body, symbolize_names: true)
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