class WeatherService
  def self.get_forecast(location)
    loc = MapService.get_location(location)
    
    # binding.pry
    
    weather = WeatherService.get_data("forecast.json?&q=#{loc[:lat]} #{loc[:lng]}") #need to insert location and the rest of the url
    binding.pry
    
    # Full 
    # http://api.weatherapi.com/v1/forecast.json?key=334c34de20a348c694143627232304&q=39.10713 -84.50413&days=1&aqi=no&alerts=no


  end
  
  def self.get_data(url)
    response = conn.get(url)
binding.pry #response has no body
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  
    def self.conn
      Faraday.new(
        url: "http://api.weatherapi.com/v1/",
        params: {
          key: ENV['WEATHER_KEY']
        },
        headers: { 'Content-Type' => 'application/json' }
      )
    end
end