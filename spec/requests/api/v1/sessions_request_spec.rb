require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  context '#create' do
    VCR.use_cassette('forecast_controller/get_forecast_index') do
      get "/api/v1/forecast?location=cincinnati,oh"
      # binding.pry
      expect(response).to be_successful
    end
  end
end