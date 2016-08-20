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
    @facebook = Koala::Facebook::API.new(facebook_token)
    #include facebook email
    profile = @facebook.get_object("me?fields=email")
    user = User.from_facebook(profile)
    render json: user
    # catch facebook error 
    rescue Koala::Facebook::APIError => e # StandardError is the root class of most errors
      render json: e
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :seeking)
    end

end