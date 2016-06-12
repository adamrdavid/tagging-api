class ApiKey < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  validates :authorization_token, uniqueness: true

  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.authorization_token = SecureRandom.hex
    end while self.class.exists?(authorization_token: authorization_token)
  end
end
