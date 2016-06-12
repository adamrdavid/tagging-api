module Api
  module V1
    class TagsController < ApplicationController
      skip_before_filter  :verify_authenticity_token
      before_filter :restrict_access
      respond_to :json


      # GET /tags/stats 
      # Example:
      # curl -X GET 'http://localhost:3000/api/tags/stats' -H 'Authorization: Token token="1d9f3251b1591a5d9529c88655950370"'
      def stats
        tag_stats = []
        @tags = Tag.all
        @tags.each do |tag|
          tag_stats << {:tag_name => tag.name, :count => tag.entities.count}
        end
        respond_with :api, :v1, tag_stats.to_json
      end
    end
  end
end