require 'rails_helper'

RSpec.describe Entity, type: :model do
  let(:tag1) {create(:tag, :name => "Blue")}
  let(:tag2) {create(:tag, :name => "Red")}
  before(:each) do
    @entity = build(
      :entity,
      :entity_id => "entity1",
      :entity_type => "Product",
      :tags => [tag1, tag2] )
  end

  it "returns entity_id" do
    expect(@entity.entity_id).to eql "entity1"
  end

  it "returns entity_type" do
    expect(@entity.entity_type).to eql "Product"
  end

  it "adds associated tags" do
    expect(@entity.tags.to_a).to eql [tag1, tag2]
  end
end
