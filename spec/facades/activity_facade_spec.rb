require 'rails_helper'

RSpec.describe ActivityFacade do
  context 'methods' do
    it '#temp_over_60' do
      VCR.use_cassette('activity_facade/temp_over_60') do
        activities = ActivityFacade.temp_over_60("chicago,il")
        #poro with activity and weather info is created
        binding.pry
      VCR.eject_cassette
      end
    end
    
    xit '#temp_between_50_60' do
      # VCR.use_cassette('activity_facade/temp_between_50_60') do
          activities = ActivityFacade.temp_between_50_60("chicago,il")
        binding.pry
      # VCR.eject_cassette
      # end
    end
    
    xit '#temp_under_50' do
      # VCR.use_cassette('activity_facade/temp_under_50') do
          activities = ActivityFacade.temp_under_50("chicago,il")
          binding.pry
      # VCR.eject_cassette
      # end
    end
  end
end