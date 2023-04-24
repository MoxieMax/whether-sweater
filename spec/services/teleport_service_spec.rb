require 'rails_helper'

RSpec.describe TeleportService do
  context 'instance methods' do
    let(:area){"chicago"}
    
    it "can #get_urban_area" do
      query = TeleportService.get_urban_area(area)
      
      expect(query).to be_a(Hash)
      expect(query.count).to eq(10)
      expect(query[:full_name]).to eq("Chicago, Illinois")
      expect(query.keys).to eq([:_links, 
                                :bounding_box, 
                                :continent, 
                                :full_name, 
                                :is_government_partner, 
                                :mayor, 
                                :name, 
                                :slug, 
                                :teleport_city_url, 
                                :ua_id])
    end
    
    it "can #get_salaries" do
      query = TeleportService.get_salaries(area)
      
      expect(query).to be_a(Hash)
      expect(query.count).to eq(2)
      expect(query.keys).to eq([:_links, :salaries])
      expect(query[:salaries].count).to eq(52)
      expect(query[:salaries].first.keys).to eq([:job, :salary_percentiles])
    end
  end
end