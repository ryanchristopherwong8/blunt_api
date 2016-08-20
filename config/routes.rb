
require 'api_constraints'

BluntApi::Application.routes.draw do
  
  # Api definition
  # Rails will automatically map that namespace to a directory matching the name under the controllers folder
  namespace :api, defaults: { format: :json }, path: '/' do # has to have api. in the front, which has a path option set to root in relation to subdomain
    
    scope module: :v1, # version control
      constraints: ApiConstraints.new(version: 1, default: true) do # versioning by headers => version is set to 1 in header of request
        # We are going to list our resources here
        #devise_for :users, defaults: { format: :json}
        resources :users, :only => [:show, :create, :update, :destroy]
        # handles the sign in(POST) and sign out(DELETE) 
        resources :sessions, :only => [:create, :destroy]

        # handles sign in from facebook
        match "users/facebook/login", to: 'users#facebook_login', via: [:post]
        # update seeking profile params
        match "users/:id/seekingprofile", to: 'seeking_profiles#update', via: [:patch]
        # return list of nearby gamers
        match "users", to: 'users#get_nearby_users', via: [:get]
    end 
  end
end