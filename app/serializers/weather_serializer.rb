class ForecastSerializer
  include JSONAPI::Serializer
  attributes :current_weather, :daily_weather, :hourly_weather
      set_type :forecast
  
  # def self.format_all(weather)
  #   {
  #     data: weather.map do|w|
  #       {
  #         id: nil,
  #         type: "forecast",
  #         attributes: {
  #           current_weather: {
  #             last_updated: w[:current][:last_updated],#in a human-readable format such as “2023-04-07 16:30”
  #             temperature: w[:current][:temp_f], #floating point number indicating the current temperature in Fahrenheit
  #             feels_like: w[:current][:feelslike_f], #floating point number indicating a temperature in Fahrenheit
  #             humidity: w[:current][:humidity], #numeric (int or float)
  #             uvi: w[:current][:uv], #numeric (int or float)
  #             visibility: w[:current], #numeric (int or float)
  #             condition: w[:current][:condition][:text], #the text description for the current weather condition
  #             icon: w[:current][:condition][:icon], #png string for current weather condition
  #           },
  #           daily_weather: w[:forecast][:forecastday].map do |d|
  #           {
  #             date: d[:date], #in a human-readable format such as “2023-04-07”
  #             sunrise: d[:astro][:sunrise], #in a human-readable format such as “07:13 AM”
  #             sunset: d[:astro][:sunset], #in a human-readable format such as “08:07 PM”
  #             max_temp: d[:day][:maxtemp_f], #floating point number indicating the maximum expected temperature in Fahrenheit
  #             min_temp: d[:day][:mintemp_f], #floating point number indicating the minimum expected temperature in Fahrenheit
  #             condition: d[:day][:condition][:text], #the text description for the weather condition
  #             icon: d[:day][:condition][:icon]# png string for weather condition
  #           }
  #           end,
  #           hourly_weather: [:forecast][:forecastday].first[:hour].map do |h|
  #           {
  #             time: h[:time],# in a human-readable format such as “22:00”
  #             temperature: h[:temp_f],# floating point number indicating the temperature in Fahrenheit for that hour
  #             conditions: h[:condition][:text],# the text description for the weather condition at that hour
  #             icon: h[:condition][:icon]# string, png string for weather condition at that hour
  #           }
  #           end
  #         }
  #       }
  #     end
  #   }
  # end
  
end
