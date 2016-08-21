class Api::V1::SeekingProfilesController < ApplicationController

	def update
    user = current_user
    if user.SeekingProfile.update(seekingprofile_params)
      render json: user, :include => :SeekingProfile, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def show
    respond_with current_user.SeekingProfile
  end

  private
    def seekingprofile_params
      params.require(:seekingprofile).permit(:minSeekDistance, :maxSeekDistance)
    end
  end
