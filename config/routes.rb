
require 'api_constraints'

BluntApi::Application.routes.draw do
  
  # Api definition
  # Rails will automatically map that namespace to a directory matching the name under the controllers folder
  namespace :api, defaults: { format: :json }, path: '/' do # has to have api. in the front, which has a path option set to root in relation to subdomain
    
    scope module: :v1, # version control
      constraints: ApiConstraints.new(version: 1, default: true) do # versioning by headers => version is set to 1 in header of request
        # We are going to list our resources here
        #devise_for :users, defaults: { format: :json}
        resources :users, :only => [:show, :update, :destroy]


        # handles sign in from facebook
        match "users/facebook/login", to: 'users#facebook_login', via: [:post]
        # update seeking profile params
        match "users/:id/seekingprofile", to: 'seeking_profiles#update', via: [:patch]
        match "users/:id/seekingprofile", to: 'seeking_profiles#show', via: [:get]
        # return list of nearby users
        match "filteredusers", to: 'users#get_filtered_users', via: [:post]
        # show gamer profile
        match "users/:id/gamerprofile", to: 'gamer_profiles#show', via: [:get]
    end 
  end
end