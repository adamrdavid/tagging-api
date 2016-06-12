require 'rails_helper'

RSpec.describe ApiKey, type: :model do

  before(:each) do
    @api_key = build(:api_key)
  end

  it "receives the generate_access_token callback before_create" do
    expect(@api_key).to receive :generate_access_token
    @api_key.save
  end

  it "generates hex string of 32 characters" do
    @api_key.save
    expect(@api_key.authorization_token.length).to eql 32
  end
end
