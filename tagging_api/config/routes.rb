require 'api_constraints'
Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :entities, :except => [:show, :update, :destroy]
      delete 'entities', to: 'entities#destroy'
      get 'entities/stats', to: 'entities#stats'

      # Tag Stats
      get 'tags/stats', to: 'tags#stats'
    end
  end
end
