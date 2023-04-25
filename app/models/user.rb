class User < ApplicationRecord
  has_secure_password
  before_create :generate_api_key
  validates :email, presence: true, 
                    uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: { on: :create }
  
  # validates :api_key, presence: true,
  #                     uniqueness: true
  # validates :api_key, presence: true
  
  private
    def generate_api_key
      self.api_key = SecureRandom.hex(10)
    end
end