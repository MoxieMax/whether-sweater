class ActivityFacade
  def self.temp_over_60(destination)
    # #if the temperature is >= 60 F, include one recreational activity.
    forecast = ForecastFacade.forecast(destination).current_weather
    
    activity_one = ActivityService.get_activity_by_type('relaxation')
    activity_two = ActivityService.get_activity_by_type('recreational')
    # binding.pry
    
    act = Activities.new([activity_one, activity_two])
    binding.pry
  end
  
  def self.temp_between_50_60(destination)
    # #if the temperature is >= 50 F and < 60 F, include one busywork activity.
    forecast = ForecastFacade.forecast(destination).current_weather
    activity_one = ActivityService.get_activity_by_type('relaxation')
    activity_two = ActivityService.get_activity_by_type('busywork')
    
    binding.pry
    # Activities.new({activity_one, activity_two})
  end
  
  def self.temp_under_50 # < 50 F(destination)
    # #if the temperature is < 50 F, include one cooking activity.
    forecast = ForecastFacade.forecast(destination).current_weather
    activity_one = ActivityService.get_activity_by_type('relaxation')
    activity_two = ActivityService.get_activity_by_type('cooking')
    binding.pry
    # Activities.new(activity_one, activity_two)
  end
end