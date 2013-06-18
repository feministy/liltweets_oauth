class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :username,     presence: true
  validates :oauth_token,  presence: true,
                           uniqueness: true
  validates :oauth_secret, presence: true,
                           uniqueness: true
end
