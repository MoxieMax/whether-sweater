class ActivityFacade
  def self.temp_over_60(destination)
    # #if the temperature is >= 60 F, include one recreational activity.
    weather = get_weather(destination)
    activity_two = ActivityService.get_activity_by_type('recreational')
    both = [activity_one, activity_two]
    data = {
            destination: destination,
            activities: format_activities(both),
            forecast_summary: get_weather(destination)[:condition],
            temperature: "#{current_temp(destination)} F"
          }
    Activities.new(data)
  end
  
  def self.temp_between_50_60(destination)
    # #if the temperature is >= 50 F and < 60 F, include one busywork activity.
    weather = get_weather(destination)
    activity_two = ActivityService.get_activity_by_type('busywork')
    both = [activity_one, activity_two]
    data = {
            destination: destination,
            activities: format_activities(both),
            forecast_summary: get_weather(destination)[:condition],
            temperature: "#{current_temp(destination)} F"
          }
    Activities.new(data)
  end
  
  def self.temp_under_50(destination)
    # #if the temperature is < 50 F, include one cooking activity.
    weather = get_weather(destination)
    activity_two = ActivityService.get_activity_by_type('cooking')
    both = [activity_one, activity_two]
    data = {
            destination: destination,
            activities: format_activities(both),
            forecast_summary: get_weather(destination)[:condition],
            temperature: "#{current_temp(destination)} F"
          }
    Activities.new(data)
  end
  
  def self.get_weather(destination)
    ForecastFacade.forecast(destination).current_weather
  end
  
  def self.activity_one
    ActivityService.get_activity_by_type('relaxation')
  end
  
  def self.current_temp(destination)
    get_weather(destination)[:temperature]
  end
  
  def self.format_activities(activities)
    activities.map do |activity|
      {
        "#{activity[:activity]}": {
          type: activity[:type],
          participants: activity[:participants],
          price: activity[:price]
        }
      }
    end
  end
end