require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  before do
    WebMock.allow_net_connect!
    # I have been banging my head against the VCR trying to get it to function, but it just doesn't want anything to do with this particular file
  end

  after do
    WebMock.disable_net_connect!
  end
  
  describe "#create User" do
    it 'when given correct params' do
      # VCR.use_cassette('users_controller/success') do
      # VCR.use_cassette('users_controller/success', match_requests_on: [:method, :path]) do
      # VCR.configuration.debug_logger = $stdout
      # VCR.use_cassette('/users_controller/success', match_requests_on: [:method, :uri]) do
        User.destroy_all
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        user_params = ({
                        email: "cavlife@ninth.net",
                        password: "FrontlineFifth",
                        password_confirmation: "FrontlineFifth"
                      })
        # post "/api/v1/users", params: user_params.to_json, headers: headers
        # puts "Endpoint: http://localhost:3000/api/v1/users"
# Rails.logger.info("Request object: #{request.inspect}")
        post "http://localhost:3000/api/v1/users", params: user_params.to_json, headers: headers
        expect(response).to be_successful
        expect(response.status).to eq(201)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        # # Add debugging statement here to check if the cassette file was created
        # puts "Cassette file: #{VCR.current_cassette.file}"
        # puts VCR.current_cassette.inspect
        
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to eq([:data])
        
        expect(parsed[:data].keys).to eq([:id, :type, :attributes])
        expect(parsed[:data][:id].to_i).to be_an(Integer)
        expect(parsed[:data][:type]).to eq("user")
        
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes][:email]).to eq("cavlife@ninth.net")
        expect(parsed[:data][:attributes][:api_key]).to be_a(String)
        expect(parsed[:data][:attributes][:password]).to be_nil
        # VCR.eject_cassette
      # end
    end
  end
  
  describe "when unsuccessful returns errors" do
    it "for existing user" do
      # VCR.use_cassette('users_controller/fail_exists') do
        User.destroy_all
        headers     = { 'CONTENT_TYPE' => 'application/json' }
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
        post "/api/v1/users", params: user_params.to_json, headers: headers
        
        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        # puts parsed
        expect(parsed[:errors]).to eq(["Email has already been taken"])
      # end
    end
    
    it "for unmatched passwords" do
      # VCR.use_cassette('users_controller/fail_passwords') do
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        user_params = ({
                        email: "lyctorish@first.mil",
                        password: "Coronabeth",
                        password_confirmation: "Corona"
                      })
        post "/api/v1/users", params: user_params.to_json, headers: headers
        
        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed[:errors]).to eq(["Password confirmation doesn't match Password"])
      # end
    end
  
    it "for missing email" do
      # VCR.use_cassette('users_controller/fail_missing_email') do
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        user_params = ({
                        email: "",
                        password: "password",
                        password_confirmation: "password"
                      })
                      
        post "/api/v1/users", params: user_params.to_json, headers: headers
        
        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed[:errors].first).to eq("Email can't be blank")
      # end
    end
  
    it "for missing password" do
      # VCR.use_cassette('users_controller/fail_missing_password') do
        headers     = { 'CONTENT_TYPE' => 'application/json' }
        user_params = ({
                        email: "AbigailPent@fifth.edu",
                        password: "",
                        password_confirmation: ""
                      })
                      
        post "/api/v1/users", params: user_params.to_json, headers: headers
        
        expect(response.status).to eq(400)
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed[:errors].first).to eq("Password can't be blank")
      # end
    end
  end
end