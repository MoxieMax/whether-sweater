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
      puts post "/api/v1/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      parse = JSON.parse(response.body, symbolize_names: true)
      
      expect(parse).to be_a(Hash)
      expect(parse.keys).to eq([:data])
      
      expect(parse[:data].keys).to eq([:id, :type, :attributes])
      expect(parse[:data][:id].to_i).to be_an(Integer)
      expect(parse[:data][:type]).to eq("user")
      
      expect(parse[:data][:attributes]).to be_a(Hash)
      expect(parse[:data][:attributes][:email]).to eq("cavlife@ninth.net")
      expect(parse[:data][:attributes][:api_key]).to be_a(String)
      expect(parse[:data][:attributes][:password]).to be_nil
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
      
      parse = JSON.parse(response.body, symbolize_names: true)
      
      expect(parse[:errors]).to eq(["Email has already been taken"])
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
      
      parse = JSON.parse(response.body, symbolize_names: true)
      
      expect(parse[:errors]).to eq(["Password confirmation doesn't match Password"])
    end
  
    it "for missing information" do
      # VCR.use_cassette('users_controller/create/fail_missing') do
      user_params = ({
                      email: "AbigailPent@fifth.edu",
                      password: "",
                      password_confirmation: ""
                    })
                    
      post "/api/v1/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
      
      expect(response.status).to eq(400)
      
      parse = JSON.parse(response.body, symbolize_names: true)
      
      expect(parse[:errors]).to eq(["Password can't be blank", "Password can't be blank", "Password confirmation can't be blank"])
    end
  end
end