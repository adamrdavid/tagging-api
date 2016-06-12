require "rails_helper"

RSpec.describe Api::V1::TagsController, :type => :request do
  let(:user) { create(:user) }
  let(:tag1) {create(:tag, :name => "Blue")}
  let(:tag2) {create(:tag, :name => "Red")}
  before(:each) do
    @api_key = ApiKey.create! :user => user
    @api_key.update_attribute :authorization_token, Rails.application.secrets.api_key
    @entity = create(
      :entity,
      :entity_id => "entity1",
      :entity_type => "Product",
      :tags => [tag1, tag2] )
  end

  describe "GET #stats" do
    it "returns count of each tag" do
      get '/api/tags/stats', nil, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(json.first['count']).to eql 1
    end
  end
end