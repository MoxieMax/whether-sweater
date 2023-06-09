require 'rails_helper'

RSpec.describe ForecastService do
  context "instance methods" do
    it 'returns ' do
      VCR.use_cassette('forecast_service/get_forecast/') do
        ws = ForecastService.get_forecast("Cincinnati, OH")
        
        expect(ws).to be_a Hash
        expect(ws.size).to eq(3)
        expect(ws[:current]).to be_a Hash
        expect(ws[:forecast]).to be_a Hash
        expect(ws[:forecast].first).to be_an Array
        expect(ws[:forecast][:forecastday]).to be_an Array
        expect(ws[:forecast][:forecastday].first).to be_a Hash
        
        # Cincinnati {:lat=>39.103119, :lng=>-84.512016}
        VCR.eject_cassette
      end
    end
  end
end