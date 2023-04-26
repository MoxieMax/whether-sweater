require 'rails_helper'

RSpec.describe 'Road Trip API', type: :request do
  context '#create Road Trip' do
    # let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
    
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
          
          binding.pry
          VCR.eject_cassette
        end
      end
    end
  end
end