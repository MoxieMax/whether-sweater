class ForecastService
  def self.get_forecast(location)
    # binding.pry
    loc = MapService.get_location(location)
    
    weather = ForecastService.get_data("forecast.json?&q=#{loc[:lat]} #{loc[:lng]}&days=5") 
    
    # http://api.weatherapi.com/v1/forecast.json?key=ENV[WEATHER_KEY]&q=39.10713 -84.50413&days=1&aqi=no&alerts=no
  end
  
  def self.get_data(url)
    response = conn.get(url)
    
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