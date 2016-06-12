require "rails_helper"

RSpec.describe Api::V1::EntitiesController, :type => :request do
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

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get '/api/entities', nil, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns 404 if no entity found" do
      get '/api/entities', {
        'entity_type'=> 'Product',
        'entity_id'=> 'bike2'},
        { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(response.body).to eql "Entity does not exist"
      expect(response).to have_http_status(404)
    end

    it "returns an entity" do
      get '/api/entities', {
        'entity_type'=> @entity.entity_type,
        'entity_id'=> @entity.entity_id
        }, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(response).to be_success
      expect("#{json.first.to_json}").to eql @entity.to_json
    end
  end

  describe "POST #create" do
    it "responds successfully with an HTTP 201 status code created" do
      post '/api/entities', {
        "entity"=> {"entity_type"=> "Product", "entity_id"=> "bike1"},
        "tags"=> ["Small", "Blue", "Bike"]
        }, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(response).to be_success
      expect(response).to have_http_status(201)
    end

    it "creates an entity\'s associated tags" do
      post '/api/entities', {
        "entity"=> {"entity_type"=> "Product", "entity_id"=> "bike1"},
        "tags"=> ["Small", "Blue", "Bike"]
        }, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(Tag.find_by(name: "Small").nil?).to eql false
    end

    it "creates an entity" do
      post '/api/entities', {
        "entity"=> {"entity_type"=> "Product", "entity_id"=> "bike1"},
        "tags"=> ["Small", "Blue", "Bike"]
        }, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(Entity.getEntity("bike1", "Product").nil?).to eql false
    end
  end

  describe "DELETE #destroy" do
    it "deletes an entity" do
      delete '/api/entities', {
        "entity_type"=> @entity.entity_type,
        "entity_id"=> @entity.entity_id,
        }, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(Entity.getEntity(@entity.entity_id, @entity.entity_type).nil?).to eql true
    end
  end

  describe "GET #stats" do
    it "returns count of an entity" do
      get '/api/entities/stats', {
        "entity_type"=> @entity.entity_type,
        "entity_id"=> @entity.entity_id,
        }, { "HTTP_AUTHORIZATION"=>"Token token=\"#{@api_key.authorization_token}\"" }
      expect(json["count"]).to eql 2
    end
  end
end