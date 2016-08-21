class Api::V1::GamerProfilesController < ApplicationController

	def update
    user = current_user
    if user.GamerProfile.update(gamerprofile_params)
      render json: user, :include => :GamerProfile, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def show
    respond_with current_user.GamerProfile
  end

  private
    def gamerprofile_params
      params.require(:gamerprofile).permit()
    end
  end
