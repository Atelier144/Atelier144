Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 
  Rails.application.credentials.twitter_api[:key], 
  Rails.application.credentials.twitter_api[:secret]
end

OmniAuth.config.on_failure = Proc.new{|env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure}