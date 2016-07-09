
require 'api_constraints'

QuicknoteApi::Application.routes.draw do
  devise_for :users, defaults: { format: :json}
  # Api definition
  # Rails will automatically map that namespace to a directory matching the name under the controllers folder
  namespace :api, defaults: { format: :json }, path: '/' do # has to have api. in the front, which has a path option set to root in relation to subdomain
    
    scope module: :v1, # version control
      constraints: ApiConstraints.new(version: 1, default: true) do # versioning by headers => version is set to 1 in header of request
        # We are going to list our resources here
        resources :users, :only => [:show, :create, :update, :destroy]
        # handles the sign in(POST) and sign out(DELETE) 
        resources :sessions, :only => [:create, :destroy]
    end 

  end

end