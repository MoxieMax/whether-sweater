require 'rails_helper'

RSpec.describe MapService, :vcr do
  context 'instance methods' do
    it 'returns lat/long' do
      #set up webmock / vcr
      loc = MapService.get_location('Cincinnati, OH')

      expect(loc).to be_a Hash
      expect(loc.size).to eq(2)
      expect(loc[:lat]).to be_a Float
      expect(loc[:lng]).to be_a Float
      
      expect(loc[:lat]).to be_between(39, 40).exclusive
      expect(loc[:lng]).to be_between(-85, -84).exclusive
    end
  end
end
