class TweetWorker
  include Sidekiq::Worker

  sidekiq_options :retry => false, :backtrace => true

  def perform(tweet_id) # Gives you access to perform_async
    tweet = Tweet.find(tweet_id)
    user = tweet.user

    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end 
end
