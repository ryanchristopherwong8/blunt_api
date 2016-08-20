require "koala"

class Api::V1::UsersController < ApplicationController
	# make sure user is authorized
	before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

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

  def near
    user = current_user
    lat = user.latitude
    long = user.longitude

    require 'json'
    lat.to_json
    long.to_json
    users = User.within(3700, :units => :kms, :origin => [user.latitude, user.longitude]).by_distance(:origin => [user.latitude, user.longitude]).where.not(username: params[:username])
    calculateShortestDistance(users, lat, long)
    render :json => @users
  end

  def update_seekingprofile
    user = current_user
    if user.SeekingProfile.update(seekingprofile_params)
      render json: user, :include => :SeekingProfile, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private

    def seekingprofile_params
      params.require(:seekingprofile).permit(:minSeekDistance, :maxSeekDistance)
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :latitude, :longitude)
    end

    def calculateShortestDistance(users, original_lat, original_long)
      require 'json'
      users.to_json
      for user in @users
        @new_lat = user.latitude
        @new_long = user.longitude
        user.distance = getShortDistance(original_lat, original_long, @new_lat, @new_long)
      end
      return @users 
    end

    def getShortDistance(original_lat, original_long, new_lat, new_long)
      dtor = Math::PI/180
      r = 6378.14*1000

      rlat1 = original_lat * dtor 
      rlong1 = original_long * dtor 
      rlat2 = new_lat * dtor 
      rlong2 = new_long * dtor 

      dlon = rlong1 - rlong2
      dlat = rlat1 - rlat2

      a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
      d = r * c
      # / 1000 for kilometers
      return d / 1000
    end

    def power(num, pow)
      num ** pow
    end

end