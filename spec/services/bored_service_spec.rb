require 'rails_helper'

describe BoredService do
  context "instance methods" do
    it '#get_random_activity' do
      VCR.use_cassette('bored_service/get_random_activity/') do
        activity = BoredService.get_random_activity
        
        expect(activity).to be_a Hash
        expect(activity.size).to eq(7)
        expect(activity.keys).to eq([:activity, :type, :participants, :price, :link, :key, :accessibility])
        expect(activity[:activity]).to be_a(String)
        expect(activity[:type]).to be_a(String)
        expect(activity[:participants]).to be_an(Integer)
        expect(activity[:price]).to be_a(Float)
        expect(activity[:link]).to be_a(String)
        expect(activity[:key]).to be_an(String)
        expect(activity[:accessibility]).to be_a(Float)
        
        VCR.eject_cassette
      end
    end
    
    it '#get_activity' do
      VCR.use_cassette('bored_service/get_activity/') do
        activity = BoredService.get_activity("1934228")
        
        expect(activity).to be_a Hash
        expect(activity.size).to eq(7)
        expect(activity.keys).to eq([:activity, :type, :participants, :price, :link, :key, :accessibility])
        expect(activity[:activity]).to be_a(String)
        expect(activity[:type]).to be_a(String)
        expect(activity[:participants]).to be_an(Integer)
        expect(activity[:price]).to be_a(Float)
        expect(activity[:link]).to be_a(String)
        expect(activity[:key]).to be_an(String)
        expect(activity[:accessibility]).to be_a(Float)
        
        VCR.eject_cassette
      end
    end
    
    it '#get_activity_by_participants' do
      VCR.use_cassette('bored_service/get_activity_by_participants/') do
        activity = BoredService.get_activity_by_participants(3)
        
        expect(activity).to be_a Hash
        expect(activity.size).to eq(7)
        expect(activity.keys).to eq([:activity, :type, :participants, :price, :link, :key, :accessibility])
        expect(activity[:activity]).to be_a(String)
        expect(activity[:type]).to be_a(String)
        expect(activity[:participants]).to eq(3)
        expect(activity[:price]).to be_a(Float)
        expect(activity[:link]).to be_a(String)
        expect(activity[:key]).to be_an(String)
        expect(activity[:accessibility]).to be_a(Float)
        
        VCR.eject_cassette
      end
    end
    
    it '#get_activity_by_type' do
      VCR.use_cassette('bored_service/get_activity_by_type/') do
        activity = BoredService.get_activity_by_type("relaxation")
        
        expect(activity).to be_a Hash
        expect(activity.size).to eq(7)
        expect(activity.keys).to eq([:activity, :type, :participants, :price, :link, :key, :accessibility])
        expect(activity[:activity]).to be_a(String)
        expect(activity[:type]).to eq("relaxation")
        expect(activity[:participants]).to be_an(Integer)
        expect(activity[:price]).to be_a(Float)
        expect(activity[:link]).to be_a(String)
        expect(activity[:key]).to be_an(String)
        expect(activity[:accessibility]).to be_a(Float)
        
        VCR.eject_cassette
      end
    end
    
    it '#get_activity_by_price' do
      VCR.use_cassette('bored_service/get_activity_by_price/') do
        activity = BoredService.get_activity_by_price(0.15)
        
        expect(activity).to be_a Hash
        expect(activity.size).to eq(7)
        
        expect(activity[:activity]).to be_a(String)
        expect(activity[:type]).to be_a(String)
        expect(activity[:participants]).to be_an(Integer)
        expect(activity[:price]).to eq(0.15)
        expect(activity[:link]).to be_a(String)
        expect(activity[:key]).to be_an(String)
        expect(activity[:accessibility]).to be_a(Float)
        
        VCR.eject_cassette
      end
    end
  end
end

# it '#get_activity_by_accessibility' do
#   VCR.use_cassette('bored_service/get_activity_by_accessibility/') do
#     activity = BoredService.get_activity_by_accessibility(0.15)
# 
#     expect(activity).to be_a Hash
#     expect(activity.size).to eq(7)
# 
#     expect(activity[:activity]).to be_a(String)
#     expect(activity[:type]).to be_a(String)
#     expect(activity[:participants]).to be_an(Integer)
#     expect(activity[:price]).to eq(0.15)
#     expect(activity[:link]).to be_a(String)
#     expect(activity[:key]).to be_an(String)
#     expect(activity[:accessibility]).to be_a(Float)
# 
#     VCR.eject_cassette
#   end
# end

# it '#get_activity_price_range' do
#   VCR.use_cassette('bored_service/get_activity_price_range/') do
#     activity = BoredService.get_activity_price_range(0, 0.01)
# 
#     expect(activity).to be_a Hash
#     expect(activity.size).to eq(7)
# 
#     expect(activity[:activity]).to be_a(String)
#     expect(activity[:type]).to be_a(String)
#     expect(activity[:participants]).to be_an(Integer)
#     expect(activity[:price]).to be_within(0.01).of(0.05)
#     expect(activity[:link]).to be_a(String)
#     expect(activity[:key]).to be_an(String)
#     expect(activity[:accessibility]).to be_a(Float)
# 
#     VCR.eject_cassette
#   end
# end