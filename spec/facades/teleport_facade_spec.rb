require 'rails_helper'

RSpec.describe TeleportFacade do
  context 'methods' do
    it 'creates a #weather_poro' do
      city = "Chicago"
      weather = TeleportFacade.weather_poro(city)
      
      expect(weather.class).to eq(Weather)
      expect(weather.current_weather.class).to eq(Hash)
      expect(weather.daily_weather.first.class).to eq(Hash)
      expect(weather.daily_weather.class).to eq(Array)
      expect(weather.hourly_weather.first.class).to eq(Hash)
      expect(weather.hourly_weather.class).to eq(Array)
    end
    
    it 'returns #salaries and creates a poro' do
      # city = "Chicago"
      # weather = WeatherFacade.forecast("Cincinnati, OH")
      # 
    end
  end
end