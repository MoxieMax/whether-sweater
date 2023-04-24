class WeatherFacade
  def forecast(loc)
    data = WeatherService.get_forecast(loc)
    Weather.new(data)
  end

  def coords(loc)
    MapService.get_location(loc)
  end
end