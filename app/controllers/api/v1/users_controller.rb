require "koala"

class Api::V1::UsersController < ApplicationController
	# make sure user is authorized
	before_action :authenticate_with_token!, only: [:update, :destroy, :get_filtered_users]
  respond_to :json

  def show
    respond_with User.find(params[:id])
  end

  def update
  	# using the current_user method in autheticable.rb, get user by session token
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

	def destroy
  	current_user.destroy
    head 204
	end

  def facebook_login
    facebook_token = params[:facebook][:token]
    facebook = Koala::Facebook::API.new(facebook_token)
    #include facebook email
    profile = facebook.get_object("me?fields=email")
    user = User.from_facebook(profile)
    #update seeking information
    
    render json: user
    # catch facebook error 
    rescue Koala::Facebook::APIError => e # StandardError is the root class of most errors
      render json: e
  end

  # Purpose: returns filtered users
  # Parameters: user object (lat,lng) and nested seeking profile with maxSeekDistance and minSeekDistance
  # SubActions: updates user object and seeking profile
  def get_filtered_users
    user = current_user
    user.update(user_params)
    user.SeekingProfile.update(params.require(:user).permit(:seekingprofile_attributes => [:maxSeekDistance, :minSeekDistance]))
    distance = user.SeekingProfile.maxSeekDistance - user.SeekingProfile.minSeekDistance    
    @users = User.within(distance, :units => :miles, :origin => [user.latitude, user.longitude]).by_distance(:origin => [user.latitude, user.longitude]).where.not(facebook_id: user.facebook_id)
    render json: {users: @users}
  end

  private
    def user_params
      params.require(:user).permit(:latitude, :longitude)
    end
end