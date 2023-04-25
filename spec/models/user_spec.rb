require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
      #https://github.com/thoughtbot/shoulda-matchers/issues/1116
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    # it { should validate_presence_of :api_key } #might work, might be reading nil
    # it { should validate_uniqueness_of :api_key } #might work, might be reading nil
  end
  
  describe 'api_key' do
    it "#generates_api_key" do
      gideon = User.new(
                          email: "cavlife@ninth.net",
                          password: "FrontlineFifth",
                          password_confirmation: "FrontlineFifth"
                        )
      
      expect(gideon.send(:generate_api_key)).to be_a(String)
    end
  end
end