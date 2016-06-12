require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user, :name => "test_user")
  end

  it "name" do
    expect(@user.name).to eql "test_user"
  end
end
