class WeatherService
  def local_weather(location)
    loc = WeatherService.get_data() #need to insert location and the rest of the url
    
    # Full 
    # http://api.weatherapi.com/v1/current.json?key=334c34de20a348c694143627232304&q=Cincinnati&aqi=no

  end
  
  def get_data(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  
    def conn
      Faraday.new(
        url: "http://api.weatherapi.com/v1/",
        params: {
          key: ENV['WEATHER_KEY']
        },
        headers: { 'Content-Type' => 'application/json' }
      )
    end
end