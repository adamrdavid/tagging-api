require 'rails_helper'

RSpec.describe Tag, type: :model do
  before(:each) do
    @tag = create(:tag, :name => 'Blue')
  end

  it "has name" do
    expect(@tag.name).to eql 'Blue'
  end
end
