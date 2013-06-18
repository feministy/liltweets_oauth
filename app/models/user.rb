class User < ActiveRecord::Base
  has_many :tweets
  
  validates :username,     presence: true
  validates :oauth_token,  presence: true,
                           uniqueness: true
  validates :oauth_secret, presence: true,
                           uniqueness: true
end
