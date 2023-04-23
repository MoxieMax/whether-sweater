class WeatherService
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
        }
      )
    end
end