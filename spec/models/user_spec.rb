require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:email) } 
    # it { should validate_uniqueness_of(:email) }
    # it { should have_secure_password }
    
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
      #https://github.com/thoughtbot/shoulda-matchers/issues/1116
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
  
  describe 'formatting'
end