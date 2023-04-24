class TeleportFacade
  def self.salaries(urban_area)
    weather = weather_poro(urban_area)
    binding.pry
    job_data = TeleportService.get_salaries(urban_area)
    binding.pry
  end

  def self.weather_poro(urban_area)
    # binding.pry
    city_name = TeleportService.get_urban_area(urban_area.downcase)[:full_name] #query doesn't work if the city name isn't lowercase, so that's fun
    WeatherFacade.forecast(city_name)
  end
end