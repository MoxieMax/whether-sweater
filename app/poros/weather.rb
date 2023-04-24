class Weather
  attr_reader :id,
              :current_weather,
              :hourly_weather,
              :daily_weather
              
  def initialize(data)
    @id              = nil
    @current_weather = current(data[:current])
    @hourly_weather  = hourly(data[:forecast][:forecastday].first[:hour].take(24))
    @daily_weather   = daily(data[:forecast][:forecastday])
  end
  
  def current(info)
    {
      last_updated: info[:last_updated],
      temperature: info[:temp_f], 
      feels_like: info[:feelslike_f], 
      humidity: info[:humidity],
      uvi: info[:uv],
      visibility: info[:vis_miles],
      condition: info[:condition][:text],
      icon: info[:condition][:icon]
    }
  end
  
  def daily(info)
    info.map do |day|
      {
        date: day[:date], 
        sunrise: day[:astro][:sunrise], 
        sunset: day[:astro][:sunset], 
        max_temp: day[:day][:maxtemp_f], 
        min_temp: day[:day][:mintemp_f], 
        condition: day[:day][:condition][:text], 
        icon: day[:day][:condition][:icon]
      }
    end
  end
  
  def hourly(info)
    info.map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end
