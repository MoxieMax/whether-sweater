require 'rails_helper'

RSpec.describe TeleportService do
  context 'instance methods' do
    let(:area){"Chicago"}
    
    it "can #get_urban_area" do
      query = TeleportService.get_urban_area(area)
      binding.pry
      
    end
  end
end