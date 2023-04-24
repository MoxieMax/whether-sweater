require 'rails_helper'

RSpec.describe TeleportFacade do
  let(:city){"Chicago"}
  let(:weather){TeleportFacade.weather_poro(city)}
  let(:salaries){TeleportFacade.salaries(city)}
  
  context 'methods' do
    it 'creates a #weather_poro' do
      expect(weather.class).to eq(Weather)
      expect(weather.current_weather.class).to eq(Hash)
      expect(weather.daily_weather.first.class).to eq(Hash)
      expect(weather.daily_weather.class).to eq(Array)
      expect(weather.hourly_weather.first.class).to eq(Hash)
      expect(weather.hourly_weather.class).to eq(Array)
    end
    
    it 'returns #salaries and creates a poro' do
      expect(salaries.class).to eq(Teleport)
      expect(salaries.id).to eq(nil)
      expect(salaries.jobs).to be_an(Array)
      expect(salaries.jobs.count).to be <=7
      expect(salaries.jobs.first.keys).to eq([:title, :min, :max])
    end
  end
end