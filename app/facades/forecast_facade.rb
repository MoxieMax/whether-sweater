class ForecastFacade
  def self.forecast(loc)
    data = ForecastService.get_forecast(loc)
    Forecast.new(data)
  end

  def self.coords(loc)
    MapService.get_location(loc)
  end
end