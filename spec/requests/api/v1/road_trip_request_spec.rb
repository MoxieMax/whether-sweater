require 'rails_helper'

RSpec.describe 'Road Trip API', type: :request do
  context '#create Road Trip' do
    before do
      User.destroy_all
      #create user
      headers = { 'CONTENT_TYPE' => 'application/json' }
      user_params = {
                      email: "cavlife@ninth.net",
                      password: "FrontlineFifth",
                      password_confirmation: "FrontlineFifth"
                    }
      post '/api/v1/users', params: user_params.to_json, headers: headers
      @user = JSON.parse(response.body, symbolize_names: true).deep_symbolize_keys
      #create user
      
      #create session
      user_params = {
                      email: "cavlife@ninth.net",
                      password: "FrontlineFifth"
                    }
      post '/api/v1/sessions', params: user_params.to_json, headers: headers
      
      @session = JSON.parse(response.body, symbolize_names: true).deep_symbolize_keys
      #create session
    end
    
    describe "when given correct params" do
      it "#creates a trip" do
        VCR.use_cassette('road_trip_api/create_road_trip') do
          trip_params = {
                          origin: 'cincinnati,oh',
                          destination: 'chicago,il',
                          api_key: @session[:data][:attributes][:api_key]
                        }
          post '/api/v1/road_trip', params: trip_params.to_json, headers: headers
          
          expect(response).to be_successful
          trip = JSON.parse(response.body, symbolize_names: true).deep_symbolize_keys
          
          expect(trip.class).to eq(Hash)
          
          expect(trip[:data].class).to eq(Hash)
          expect(trip[:data].keys).to eq([:id, :type, :attributes])
          expect(trip[:data][:id]).to eq(nil)
          expect(trip[:data][:type]).to eq("road_trip")
          
          expect(trip[:data][:attributes].class).to eq(Hash)
          expect(trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
          
          expect(trip[:data][:attributes][:start_city]).to eq("cincinnati,oh")
          expect(trip[:data][:attributes][:end_city]).to eq("chicago,il")
          
          expect(trip[:data][:attributes][:travel_time]).to eq("04:42:32")
          
          expect(trip[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
          expect(trip[:data][:attributes][:weather_at_eta]).to eq({:condition=>"Sunny", :datetime=>"2023-04-26 13:00", :temperature=>48.2})
          # expect(trip[:data][:attributes][:weather_at_eta].class).to eq(Hash)
          #needs to change to match json response
          VCR.eject_cassette
        end
      end
      
      it "#creates a longer trip" do
        VCR.use_cassette('road_trip_api/create_long_trip') do
          trip_params = {
                          origin: 'new york,ny',
                          destination: 'panama city, panama',
                          api_key: @session[:data][:attributes][:api_key]
                        }
          post '/api/v1/road_trip', params: trip_params.to_json, headers: headers
          
          expect(response).to be_successful
          trip = JSON.parse(response.body, symbolize_names: true).deep_symbolize_keys
          
          expect(trip.class).to eq(Hash)
          
          expect(trip[:data].class).to eq(Hash)
          expect(trip[:data].keys).to eq([:id, :type, :attributes])
          expect(trip[:data][:id]).to eq(nil)
          expect(trip[:data][:type]).to eq("road_trip")
          
          expect(trip[:data][:attributes].class).to eq(Hash)
          expect(trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
          
          expect(trip[:data][:attributes][:start_city]).to eq('new york,ny')
          expect(trip[:data][:attributes][:end_city]).to eq('panama city, panama')
          
          expect(trip[:data][:attributes][:travel_time]).to eq("80:30:16")
          
          expect(trip[:data][:attributes][:weather_at_eta].keys).to eq([:datetime, :temperature, :condition])
          
          expect(trip[:data][:attributes][:weather_at_eta]).to eq({:condition=>"Moderate rain", :datetime=>"2023-04-29", :temperature=>81.0})
          #needs to change to match json response
          VCR.eject_cassette
        end
      end
    end
      
    describe "when given impossible params" do
      # Traveling from New York, NY to London, UK, weather block should be empty and travel time should be “impossible”
      it "does not #create a trip" do
        VCR.use_cassette('road_trip_api/impossible_road_trip') do
          trip_params = {
                          origin: 'new york,ny',
                          destination: 'london,uk',
                          api_key: @session[:data][:attributes][:api_key]
                        }
          post '/api/v1/road_trip', params: trip_params.to_json, headers: headers
          
          expect(response).to be_successful
          trip = JSON.parse(response.body, symbolize_names: true).deep_symbolize_keys
          
          expect(trip.class).to eq(Hash)
          
          expect(trip[:data].class).to eq(Hash)
          expect(trip[:data].keys).to eq([:id, :type, :attributes])
          expect(trip[:data][:id]).to eq(nil)
          expect(trip[:data][:type]).to eq("road_trip")
          
          expect(trip[:data][:attributes].class).to eq(Hash)
          expect(trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
          expect(trip[:data][:attributes][:start_city]).to eq("new york,ny")
          expect(trip[:data][:attributes][:end_city]).to eq("london,uk")
          expect(trip[:data][:attributes][:travel_time]).to eq("impossible")
          expect(trip[:data][:attributes][:weather_at_eta]).to eq({})
          
          VCR.eject_cassette
        end
      end
      
      it "does not #create a trip" do
        VCR.use_cassette('road_trip_api/unauthorized_road_trip') do
          trip_params = {
                          origin: 'cincinnati,oh',
                          destination: 'chicago,il',
                          api_key: "string"
                        }
          post '/api/v1/road_trip', params: trip_params.to_json, headers: headers
      
          expect(response).to be_successful
          
          trip = JSON.parse(response.body, symbolize_names: true).deep_symbolize_keys
          
          expect(trip.class).to eq(Hash)
          
          expect(trip.keys).to eq([:error, :status])
          
          expect(trip[:error]).to eq("Unauthorized")
          expect(trip[:status]).to eq(401)
      
          VCR.eject_cassette
        end
      end
    end
  end
end

# Your code should allow for the following: (NOTE: These scenarios are expected in your POSTMAN Demo)
# Traveling from New York, NY to Los Angeles, CA, with appropriate weather in L.A. when you arrive __40 hours later__
