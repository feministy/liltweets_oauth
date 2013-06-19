class User < ActiveRecord::Base
  has_many :tweets

  validates_presence_of :username, :oauth_token, :oauth_secret
  validates_uniqueness_of :oauth_token, :oauth_secret 

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end

  def tweet_in(interval, status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_in(interval.hours, tweet.id)
  end

  def tweet_at(timestamp, status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_at(interval.hours.from_now, tweet.id)
  end  
end

# user = User.create(things)
# user.tweet("I love cheese.")
