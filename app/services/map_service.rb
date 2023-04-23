class MapService
  def get_data(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  
    def conn
      Faraday.new(
        url: "https://www.mapquestapi.com/geocoding/v1/address",
        params: {
          key: ENV['WEATHER_KEY']
        }
      )
    end
end