QuickNoteApi::Application.routes.draw do
  # Api definition
  # Rails will automatically map that namespace to a directory matching the name under the controllers folder
  namespace :api, defaults: { format: :json }, 
    constraints: { subdomain: 'api' }, path: '/' do # has to have api. in the front, which has a path option set to root in relation to subdomain
    
    scope module: :v1 do, # version control
      constraints: ApiConstraints.new(version: 1, default: true) do # versioning by headers => version is set to 1 in header of request
        # We are going to list our resources here
    end 

  end

end