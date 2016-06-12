module Api
  module V1
    class EntitiesController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access unless Rails.env = "test"
      before_action :validate_entity_params, except: [:index, :create]
      respond_to :json

      # GET /entities
      # Returns all entities in json format
      # Example:
      # curl http://localhost:3000/api/entities -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
      # curl -X GET 'http://localhost:3000/api/entities?entity_type=Product&entity_id=bike2' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
      def index
        if params[:entity_type]
          validate_entity_params
          @entity = set_entity
          respond_with :api, :v1, [@entity, @entity.tags].to_json and return unless @entity.nil?
          render :json => "Entity does not exist", status: 404
        else
          @entities = Entity.all
          respond_with :api, :v1, @entities, status: 200
        end
      end

      # POST /entity
      # Example:
      # curl -H "Content-Type: application/json" -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"' -d '{"entity": {"entity_type": "Product", "entity_id": "bike5"}, "tags": ["Small", "Blue", "Bike"]}' -X POST 'http://localhost:3000/api/entities'
      def create
        begin
          params.require(:entity).permit(
            :entity_id,
            :entity_type
          )
          params.require(:tags)
        rescue Exception => e
          render json: { message: e.message }, status: :unprocessable_entity and return
        end
        tags = Tag.getOrCreateTags(params[:tags])
        @old_entity = set_entity
        if @old_entity.nil?
          @new_entity = Entity.new(
            :entity_id => params[:entity][:entity_id],
            :entity_type => params[:entity][:entity_type]
          )
          @new_entity.tags = tags
          @new_entity.save!
          render :json => @new_entity.to_json, :status => :created
        else
          @old_entity.update_attribute :tags, tags
          render :json => @old_entity.to_json, :status => :created
        end
      end

      # DELETE /entities
      # Example:
      # curl -X DELETE 'http://localhost:3000/api/entities?entity_type=Product&entity_id=bike5' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
      def destroy
        @entity = set_entity
        respond_with :api, :v1, @entity.destroy and return unless @entity.nil?
        render :json => "Entity does not exist", status: 404
      end  

      # GET /entities/stats 
      # Example:
      # curl -X GET 'http://localhost:3000/api/entities/stats?entity_type=Product&entity_id=bike5' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
      def stats
        @entity = set_entity
        respond_with :api, :v1, {
          :entity => @entity,
          :count => @entity.tags.length
        }.to_json and return unless @entity.nil?
        render :json => "Entity does not exist", status: 404
      end

      private

      def validate_entity_params
        begin
          params.require(:entity_id)
          params.require(:entity_type)
        rescue Exception => e
          render json: { message: e.message }, status: :unprocessable_entity and return
        end
      end

      def set_entity
        entity_id = params[:entity_id].nil? ? params[:entity][:entity_id] : params[:entity_id]
        entity_type = params[:entity_type].nil? ? params[:entity][:entity_type] : params[:entity_type]
        Entity.getEntity(entity_id, entity_type)
      end
    end
  end
end