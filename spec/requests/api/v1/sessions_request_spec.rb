require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  context '#create Session' do
    let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
    
    before do
      User.destroy_all
      user_params = {
                      email: "cavlife@ninth.net",
                      password: "FrontlineFifth",
                      password_confirmation: "FrontlineFifth"
                    }
    
      post '/api/v1/users', params: user_params.to_json, headers: headers
    end
    
    describe 'when given correct params' do
      it "#creates a session" do
        VCR.use_cassette('sessions_controller/create_success') do
          user_params = {
                          email: "cavlife@ninth.net",
                          password: "FrontlineFifth"
                        }
          
          post '/api/v1/sessions', params: user_params.to_json, headers: headers
          
          expect(response.status).to eq(200)
          
          parsed = JSON.parse(response.body, symbolize_names: true)
          
          expect(parsed).to be_a(Hash)
          expect(parsed[:data]).to be_a(Hash)
          expect(parsed[:data][:type]).to eq('user')
          expect(parsed[:data][:attributes]).to be_a(Hash)
          expect(parsed[:data][:attributes].count).to eq(2)
          expect(parsed[:data][:attributes][:email]).to eq("cavlife@ninth.net")
          expect(parsed[:data][:attributes]).to include(:email, :api_key)
          expect(parsed[:data][:attributes]).to_not include(:password)
        end
      end
    end
    
    describe 'when given incorrect params' do
      it "does not create a session with incorrect password" do
        # VCR.use_cassette('sessions_controller/create_failure_pw') do
          user_params = {
                          email: "cavlife@ninth.net",
                          password: "FrontlineFif"
                        }
          
          post '/api/v1/sessions', params: user_params.to_json, headers: headers
          
          expect(response.status).to eq(400)
          
          parsed = JSON.parse(response.body, symbolize_names: true)
          
          expect(parsed.class).to eq(Hash)
          expect(parsed[:errors]).to eq("Your credentials are bad and you should feel bad")
        # end
      end
    end
    
    it "does not create a session with incorrect email" do
      # VCR.use_cassette('sessions_controller/create_failure_email') do
        user_params = {
                        email: "cavscout@ninth.net",
                        password: "FrontlineFifth"
                      }
        
        post '/api/v1/sessions', params: user_params.to_json, headers: headers
        
        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed.class).to eq(Hash)
        expect(parsed[:errors]).to eq("Your credentials are bad and you should feel bad")
      # end
    end
  end
end