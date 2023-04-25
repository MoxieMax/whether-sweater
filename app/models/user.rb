class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, 
                    uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: { on: :create }
  
  before_create :generate_api_key
  
  private
    def generate_api_key
      self.api_key = SecureRandom.hex(10)
    end
end