require 'rails_helper'

RSpec.describe WeatherFacade do
  context 'methods' do
    it 'returns a #forecast and creates a poro' do
      weather = WeatherFacade.forecast("Cincinnati, OH")
      
      expect(weather.class).to eq(Weather)
      expect(weather.id).to eq(nil)
      
      expect(weather.current_weather.class).to eq(Hash)
      expect(weather.current_weather.keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
      
      expect(weather.current_weather.keys).not_to include(:wind_mph)
      
      expect(weather.hourly_weather.class).to eq(Array)
      expect(weather.hourly_weather.first.class).to eq(Hash)
      expect(weather.hourly_weather.count).to eq(24)
      expect(weather.hourly_weather.first.keys).to eq([:time, :temperature, :conditions, :icon])
      expect(weather.hourly_weather.first.keys).not_to include(:windchill_f)
      
      expect(weather.daily_weather.class).to eq(Array)
      expect(weather.daily_weather.first.class).to eq(Hash)
      expect(weather.daily_weather.count).to eq(5)
      expect(weather.daily_weather.first.keys).to eq([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
      
      expect(weather.daily_weather.first.keys).not_to include(:moon_phase)
    end
    
    it 'returns a set of #coords' do
      coords = WeatherFacade.coords("Cincinnati, OH")
      
      expect(coords).to be_a(Hash)
      expect(coords[:lat]).to eq(39.10713)
      expect(coords[:lng]).to eq(-84.50413)
    end
  end
end