class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :name, :longitude, :latitude, :provider
end
