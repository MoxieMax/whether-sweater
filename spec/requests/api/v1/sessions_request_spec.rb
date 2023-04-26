require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  context '#create Session' do
    it 'when given correct params' do
      VCR.use_cassette('sessions_controller/create_success') do
        # get "/api/v1/forecast?location=cincinnati,oh"
        # binding.pry
        expect(response).to be_successful
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