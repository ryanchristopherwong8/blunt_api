require 'open-uri'
class Api::V1::FacebookLoginController < ApplicationController
  def create
  	# get facebook_token from body of request
  	facebook_token = params[:facebook][:token]
    #response = open('https://graph.facebook.com/me?fields=id&access_token=' + facebook_token).read
    # send request to facebook to validate token
    file = open(URI.encode('https://graph.facebook.com/me?fields=id&access_token=' + facebook_token))

    facebook = JSON.parse(file.read)

    if facebook["data"].present?
      @result = "200"
    else
      @result = "403"
    end

    respond_with(@result)

    #data = JSON.parse(response)["data"]
    #if response["status"] == "failure"
    #    render json: { errors: "could not verify facebook token" } 
    #else
    #    do_something_else
    #end
  end
end
