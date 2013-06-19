class TweetWorker
  include Sidekiq::Worker

  sidekiq_options :retry => false, :backtrace => true

  def perform(tweet_id) # Gives you access to perform_async
    tweet = Tweet.find(tweet_id)
    user = tweet.user

    twitter_user ||= Twitter::Client.new(
      oauth_token: user.oauth_token,
      oauth_token_secret: user.oauth_secret)

    twitter_user.update(tweet.status)

    # @twitter_user ||= Twitter::Client.new(
    #     oauth_token: current_user.oauth_token,
    #     oauth_token_secret: current_user.oauth_secret
    #   )
    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end 
end
