require 'rails_helper'

RSpec.describe 'Forecast API', type: :request do
  it 'pulls the forecast for the location' do
    VCR.use_cassette('forecast_controller/get_forecast_index') do
      get "/api/v1/forecast?location=cincinnati,oh"
      # binding.pry
      expect(response).to be_successful
      
      fc = JSON.parse(response.body, symbolize_names:true)
      
      expect(fc[:data]).to be_a(Hash)
      expect(fc[:id]).to be nil
      expect(fc[:data][:type]).to eq('forecast')
      expect(fc[:data][:attributes]).to be_a(Hash)
      
      expect(fc[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(fc[:data][:attributes][:current_weather].length).to eq(8)
      expect(fc[:data][:attributes][:current_weather]).to include(:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon)
      
      expect(fc[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(fc[:data][:attributes][:daily_weather].length).to eq(5)
      expect(fc[:data][:attributes][:daily_weather].first).to be_a Hash
      expect(fc[:data][:attributes][:daily_weather].first.length).to eq(7)
      expect(fc[:data][:attributes][:daily_weather].first).to include(:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon)
      
      expect(fc[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(fc[:data][:attributes][:hourly_weather].length).to eq(24)
      expect(fc[:data][:attributes][:hourly_weather].first).to be_a(Hash)
      expect(fc[:data][:attributes][:hourly_weather].first.length).to eq(4)
      expect(fc[:data][:attributes][:hourly_weather].first.keys).to eq([:time, :temperature, :conditions, :icon])
      VCR.eject_cassette
    end
  end
end