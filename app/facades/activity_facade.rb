class ActivityFacade
  def self.temp_over_60(destination)
    # #if the temperature is >= 60 F, include one recreational activity.
    # forecast = ForecastFacade.forecast(destination).current_weather
    weather = get_weather(destination)
    activity_two = ActivityService.get_activity_by_type('recreational')
    both = [activity_one, activity_two]
    # binding.pry
    data = {
            destination: destination,
            # activities: ,
            forecast_summary: get_weather(destination)[:condition],
            temperature: "#{current_temp(destination)} F"
          }
    # Activities.new([activity_one, activity_two])
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
    # binding.pry
  end
  
  def self.activity_one
    ActivityService.get_activity_by_type('relaxation')
  end
  
  def self.current_temp(destination)
    get_weather(destination)[:temperature]
  end
end