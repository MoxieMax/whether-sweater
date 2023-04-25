require 'rails_helper'

RSpec.describe "UserController", type: :request do
  let(:correct_params) do {
                            email: "cavlife@ninth.net",
                            password: "FrontlineFifth",
                            password_confirmation: "FrontlineFifth"
                          }
                       end
  
  let(:unmatch_params) do {
                            email: "lyctorish@first.mil",
                            password: "Coronabeth",
                            password_confirmation: "Corona"
                          }
                       end
  
  let(:missing_param1) do {
                            email: "",
                            password: "password",
                            password_confirmation: "password"
                          }
                       end
  
  let(:missing_param2) do {
                            email: "AbigailPent@fifth.edu",
                            password: "",
                            password_confirmation: ""
                          }
                       end
  
  
  describe "when successful" do
    it '#creates new user' do
      User.destroy_all
      
      VCR.use_cassette('users_controller/create/success') do
        post "/api/v1/users", params: correct_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
        binding.pry
        expect(response).to be_successful
        binding.pry
      VCR.eject_cassette
      end
    end
  end
  
  # describe "when unsuccessful returns errors" do
  #   it "for existing user" do
  #   #   VCR.use_cassette('users_controller/create/fail_exists') do
  #   #     post "http://localhost:3000/api/v1/users", params:
  #   #     binding.pry
  #   #   VCR.eject_cassette
  #   #   end
  #   end
  # 
  #   it "for unmatched passwords" do
  #   #   VCR.use_cassette('users_controller/create/fail_passwords') do
  #   #     post "http://localhost:3000/api/v1/users", params:
  #   #     binding.pry
  #   #   VCR.eject_cassette
  #   #   end
  #   end
  # 
  #   it "for missing information" do
  #   #   VCR.use_cassette('users_controller/create/fail_missing') do
  #   #     post "http://localhost:3000/api/v1/users", params:
  #   #     binding.pry
  #   #   VCR.eject_cassette
  #   #   end
  #   end
  # end
  # 
  # describe "when unsuccessful" do
  #   it '#creates new user' do
  #     VCR.use_cassette('users_controller/create') do
  #       post "http://localhost:3000/api/v1/users", params:
  #       binding.pry
  #     VCR.eject_cassette
  #     end
  #   end
  # end
  # 
  # describe "when unsuccessful" do
  #   # it '#creates new user' do
  #   #   VCR.use_cassette('users_controller/create') do
  #   #     post "http://localhost:3000/api/v1/users", params:
  #   #     binding.pry
  #   #   VCR.eject_cassette
  #   #   end
  #   # end
  # end
end