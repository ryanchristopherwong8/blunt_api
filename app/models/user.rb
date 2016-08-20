class User < ActiveRecord::Base
  has_one :GamerProfile
  validates :auth_token, uniqueness: true
  devise :rememberable, :trackable
  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

   def user_signed_in?
    current_user.present?
  end

  def self.from_facebook(profile)
    # find first user based on id or initialize and than create user
    where(:facebook_id => profile["id"]).first_or_initialize.tap do |user|
      user.provider = "facebook"
      user.facebook_id = profile["id"]
      user.name = profile["name"]
      user.email = profile["email"]
      user.generate_authentication_token!
      user.save!
    end
  end

end
