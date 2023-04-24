class WeatherFacade
  def self.forecast(loc)
    data = WeatherService.get_forecast(loc)
    Weather.new(data)
  end

  def self.coords(loc)
    MapService.get_location(loc)
  end
end