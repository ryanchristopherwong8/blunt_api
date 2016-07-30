require 'koala'
class Api::V1::FacebookController < ApplicationController
  def create
  	facebook_token = params[:facebook][:token]
    @graph = Koala::Facebook::API.new(facebook_token)
    profile = @graph.get_object("me")
    render json: profile
  end
end
