Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter, TWITTER_CONSUMER_KEY, TWITTER_SECRET_KEY
end