require 'rails_helper'

describe 'Activities API Request', type: :request do
  it 'pulls the forecast for the location' do
    VCR.use_cassette('forecast_controller/get_forecast') do
      get "/api/v1/activities?destination=chicago,il"
      
      expect(response).to be_successful
      
      activities = JSON.parse(response.body, symbolize_names:true)
      
      # binding.pry
      
      expect(activities).to be_a(Hash)
      expect(activities.keys).to eq([:data])
      expect(activities[:data].keys).to eq([:id, :type, :attributes])
      
      expect(activities[:data][:id]).to eq(nil)
      expect(activities[:data][:type]).to eq("activities")
      expect(activities[:data][:attributes].keys).to eq([:destination, :forecast, :activities])
      expect(activities[:data][:attributes][:destination]).to eq("chicago,il")
      
      expect(activities[:data][:attributes][:forecast]).to be_a(Hash)
      expect(activities[:data][:attributes][:forecast][:summary]).to eq("Partly cloudy")
      expect(activities[:data][:attributes][:forecast][:temperature]).to eq("44.1 F")
      
      expect(activities[:data][:attributes][:activities]).to be_an(Array)
      expect(activities[:data][:attributes][:activities].first).to be_a(Hash)
      expect(activities[:data][:attributes][:activities].first).to have_key(:"Start a daily journal")
      
      expect(activities[:data][:attributes][:activities].first[:"Start a daily journal"].keys).to eq([:type, :participants, :price])
      
      # expect(activities[:data][:attributes][:activities].first[:"Start a daily journal"]).to have_keys(:type, :participants, :price)
      
      
      
      
      # binding.pry
      VCR.eject_cassette
    end
  end
end