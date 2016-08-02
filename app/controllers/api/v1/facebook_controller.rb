require 'koala'
class Api::V1::FacebookController < ApplicationController
  def create
  	facebook_token = params[:facebook][:token]
    @facebook = Koala::Facebook::API.new(facebook_token)
    #include facebook email
    profile = @facebook.get_object("me?fields=email")
   	user = User.from_facebook(profile)
   	render json: user
  	# catch facebook error 
    rescue Koala::Facebook::APIError => e # StandardError is the root class of most errors
   		render json: e
  end
end
