require 'rails_helper'

describe UserController, type: :request do
  describe "when successful" do
    it '#creates new user' do
      VCR.use_cassette('users_controller/create') do
        post "http://localhost:3000/api/v1/users", params:
        binding.pry
      VCR.eject_cassette
      end
    end
  end
  
  describe "when unsuccessful returns errors" do
    it "for existing user" do
    #   VCR.use_cassette('users_controller/create') do
    #     post "http://localhost:3000/api/v1/users", params:
    #     binding.pry
    #   VCR.eject_cassette
    #   end
    end
    
    it "for unmatched passwords" do
    #   VCR.use_cassette('users_controller/create') do
    #     post "http://localhost:3000/api/v1/users", params:
    #     binding.pry
    #   VCR.eject_cassette
    #   end
    end
    
    it "for missing information" do
    #   VCR.use_cassette('users_controller/create') do
    #     post "http://localhost:3000/api/v1/users", params:
    #     binding.pry
    #   VCR.eject_cassette
    #   end
    end
  end
  
  describe "when unsuccessful" do
    it '#creates new user' do
      VCR.use_cassette('users_controller/create') do
        post "http://localhost:3000/api/v1/users", params:
        binding.pry
      VCR.eject_cassette
      end
    end
  end
  
  describe "when unsuccessful" do
    # it '#creates new user' do
    #   VCR.use_cassette('users_controller/create') do
    #     post "http://localhost:3000/api/v1/users", params:
    #     binding.pry
    #   VCR.eject_cassette
    #   end
    # end
  end
end