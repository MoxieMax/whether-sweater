require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  context '#create Session' do
    let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
    
    before do
      user_params = {
                      email: "cavlife@ninth.net",
                      password: "FrontlineFifth",
                      password_confirmation: "FrontlineFifth"
                    }
      
      post '/api/v1/users', params: user_params.to_json, headers: headers
    end
    
    it 'when given correct params' do
      VCR.use_cassette('sessions_controller/create_success') do
        # post "/api/v1/sessions"
        # binding.pry
        expect(response).to be_successful
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        # binding.pry
        
        expect(parsed).to be_a(Hash)
        expect(parsed[:data]).to be_a(Hash)
        expect(parsed[:data][:type]).to eq('user')
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes].count).to eq(2)
        expect(parsed[:data][:attributes][:email]).to eq("cavlife@ninth.net")
        expect(parsed[:data][:attributes]).to include(:email, :api_key)
        # binding.pry
      end
    end
    
    # it 'when given incorrect params' do
    #   VCR.use_cassette('sessions_controller/create_failure') do
    #     # get "/api/v1/forecast?location=cincinnati,oh"
    #     # binding.pry
    #     expect(response).to be_successful
    #   end
    # end
  end
end