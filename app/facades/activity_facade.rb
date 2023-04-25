class ActivityFacade
  def temp_over_60(destination)
    # #if the temperature is >= 60 F, include one recreational activity.
    forecast = ForecastFacade.forecast(destination).current_weather
    
    activity_one = ActivityService.get_activity_by_type('relaxation')
    activity_two = ActivityService.get_activity_by_type('recreational')
    binding.pry
  end
  
  def temp_between_50_60(destination)
    # #if the temperature is >= 50 F and < 60 F, include one busywork activity.
    forecast = ForecastFacade.forecast(destination).current_weather
    activity_one = ActivityService.get_activity_by_type('relaxation')
    activity_two = ActivityService.get_activity_by_type('busywork')
    binding.pry
  end
  
  def temp_under_50 # < 50 F(destination)
    # #if the temperature is < 50 F, include one cooking activity.
    forecast = ForecastFacade.forecast(destination).current_weather
    activity_one = ActivityService.get_activity_by_type('relaxation')
    activity_two = ActivityService.get_activity_by_type('cooking')
    binding.pry
  end
end