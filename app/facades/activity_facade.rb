class ActivityFacade
  def self.temp_over_60(destination)
    # #if the temperature is >= 60 F, include one recreational activity.
    # forecast = ForecastFacade.forecast(destination).current_weather
    weather = get_weather(destination)
    activity_two = ActivityService.get_activity_by_type('recreational')
    # binding.pry
    
    Activities.new([activity_one, activity_two])
    # binding.pry
  end
  
  def self.temp_between_50_60(destination)
    # #if the temperature is >= 50 F and < 60 F, include one busywork activity.
    activity_two = ActivityService.get_activity_by_type('busywork')
    
    binding.pry
    act = Activities.new([activity_one, activity_two])
  end
  
  def self.temp_under_50(destination) # < 50 F(destination)
    # #if the temperature is < 50 F, include one cooking activity.
    forecast = ForecastFacade.forecast(destination).current_weather
    activity_two = ActivityService.get_activity_by_type('cooking')
    binding.pry
    act = Activities.new([activity_one, activity_two])
  end
  
  def self.get_weather(destination)
    ForecastFacade.forecast(destination).current_weather
  end
  
  def self.activity_one
    ActivityService.get_activity_by_type('relaxation')
  end
  
  # def self.forecast_poro(destination)
  #   WeatherFacade.forecast(destination)
  # end
  
  # def self.activities_poro
  # 
  # end
  
end