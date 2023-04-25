require 'rails_helper'

RSpec.describe ActivityFacade do
  context 'methods' do
    it '#temp_over_60' do
      VCR.use_cassette('activity_facade/temp_over_60') do
        activities = ActivityFacade.temp_over_60("chicago,il")
        #poro with activity and weather info is created
        
        expect(activities).to be_an_instance_of(Activities)
        
        expect(activities.id).to eq(nil)
        
        expect(activities.activities.class).to eq(Array)
        expect(activities.activities.first.class).to eq(Hash)
        expect(activities.activities.first[:"Draw and color a Mandala"][:type]).to eq('relaxation')
        
        expect(activities.activities.last.class).to eq(Hash)
        expect(activities.activities.last[:"Go for a run"][:type]).to eq('recreational')
        
        expect(activities.destination).to eq("chicago,il")
        
        expect(activities.forecast).to be_a(Hash)
        expect(activities.forecast.count).to eq(2)
        expect(activities.forecast.keys).to eq(["summary", "temperature"])
      VCR.eject_cassette
      end
    end
    
    it '#temp_between_50_60' do
      VCR.use_cassette('activity_facade/temp_between_50_60') do
        activities = ActivityFacade.temp_between_50_60("chicago,il")

        expect(activities).to be_an_instance_of(Activities)
        
        expect(activities.id).to eq(nil)
        
        expect(activities.activities.class).to eq(Array)
        expect(activities.activities.first.class).to eq(Hash)
        expect(activities.activities.first[:"Start a book you've never gotten around to reading"][:type]).to eq('relaxation')
        
        expect(activities.activities.last.class).to eq(Hash)
        expect(activities.activities.last[:"Clean out your garage"][:type]).to eq('busywork')
        
        expect(activities.destination).to eq("chicago,il")
        
        expect(activities.forecast).to be_a(Hash)
        expect(activities.forecast.count).to eq(2)
        expect(activities.forecast.keys).to eq(["summary", "temperature"])
      VCR.eject_cassette
      end
    end
    
    it '#temp_under_50' do
      VCR.use_cassette('activity_facade/temp_under_50') do
          activities = ActivityFacade.temp_under_50("chicago,il")
          
          expect(activities).to be_an_instance_of(Activities)
          
          expect(activities.id).to eq(nil)
          
          expect(activities.activities.class).to eq(Array)
          expect(activities.activities.first.class).to eq(Hash)
          expect(activities.activities.first[:"Color"][:type]).to eq('relaxation')
          
          expect(activities.activities.last.class).to eq(Hash)
          expect(activities.activities.last[:"Make homemade ice cream"][:type]).to eq('cooking')
          
          expect(activities.destination).to eq("chicago,il")
          
          expect(activities.forecast).to be_a(Hash)
          expect(activities.forecast.count).to eq(2)
          expect(activities.forecast.keys).to eq(["summary", "temperature"])
      VCR.eject_cassette
      end
    end
  end
end