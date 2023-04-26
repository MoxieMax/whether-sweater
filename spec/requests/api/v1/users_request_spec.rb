require 'rails_helper'

RSpec.describe "UserController", :vcr do
  describe "#create User" do
    it 'when given correct params' do
      # VCR.use_cassette('users_controller/create/success') do
      User.destroy_all
      user_params = ({
                      email: "cavlife@ninth.net",
                      password: "FrontlineFifth",
                      password_confirmation: "FrontlineFifth"
                    })
      post "/api/v1/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed).to be_a(Hash)
      expect(parsed.keys).to eq([:data])
      
      expect(parsed[:data].keys).to eq([:id, :type, :attributes])
      expect(parsed[:data][:id].to_i).to be_an(Integer)
      expect(parsed[:data][:type]).to eq("user")
      
      expect(parsed[:data][:attributes]).to be_a(Hash)
      expect(parsed[:data][:attributes][:email]).to eq("cavlife@ninth.net")
      expect(parsed[:data][:attributes][:api_key]).to be_a(String)
      expect(parsed[:data][:attributes][:password]).to be_nil
    end
  end
  
  describe "when unsuccessful returns errors" do
    it "for existing user" do
      #   VCR.use_cassette('users_controller/create/fail_exists') do
      user = User.create!(
                          email: "cavlife@ninth.net",
                          password: "FrontlineFifth",
                          password_confirmation: "FrontlineFifth"
                         )
      user_params = ({
                      email: user.email,
                      password: "password",
                      password_confirmation: "password"
                    })
      post "/api/v1/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      
      expect(response.status).to eq(400)
      
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed[:errors]).to eq(["Email has already been taken"])
    end
    
    it "for unmatched passwords" do
    #   VCR.use_cassette('users_controller/create/fail_passwords') do
    user_params = ({
                    email: "lyctorish@first.mil",
                    password: "Coronabeth",
                    password_confirmation: "Corona"
                  })
      post "/api/v1/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      
      expect(response.status).to eq(400)
      
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed[:errors]).to eq(["Password confirmation doesn't match Password"])
    end
  
    it "for missing email" do
      # VCR.use_cassette('users_controller/create/fail_missing') do
      user_params = ({
                      email: "",
                      password: "password",
                      password_confirmation: "password"
                    })
                    
      post "/api/v1/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      
      expect(response.status).to eq(400)
      
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed[:errors].first).to eq("Email can't be blank")
    end
  
    it "for missing password" do
      # VCR.use_cassette('users_controller/create/fail_missing') do
      user_params = ({
                      email: "AbigailPent@fifth.edu",
                      password: "",
                      password_confirmation: ""
                    })
                    
      post "/api/v1/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      
      expect(response.status).to eq(400)
      
      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed[:errors].first).to eq("Password can't be blank")
    end
  end
end