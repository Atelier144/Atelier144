Rails.application.routes.draw do

  root "home#top"

  get "/games", to: "home#games"
  get "/apps", to: "home#apps"
  get "/news", to: "home#news"
  get "/terms", to: "home#terms"
  get "/privacy", to: "home#privacy"
  get "/contact", to: "home#contact"

  get "/profiles/:id", to: "users#show"

  get "/login" , to: "users#login_form"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout"
  get "/signup", to: "users#signup_form"
  post "/signup", to: "users#signup"

  get "/login/forgot_password", to: "users#forgot_password_form"
  post "/login/forgot_password", to: "users#forgot_password"
  get "/login/forgot_password/certificated", to: "users#certificated_forgot_password"

  get "/new_password/:hash", to: "users#new_password_form"
  post "/new_password/:hash", to: "users#new_password"

  post "/signup/username_confirmation", to: "users#signup_username_confirmation"
  post "/signup/email_confirmation", to: "users#signup_email_confirmation"

  get "/auth/twitter/callback", to: "users#twitter"
  get "/auth/facebook/callback", to: "users#facebook"

  get "/auth/failure", to: "users#social_failure"

  post "/twitter", to: "users#twitter_post"
  post "/facebook", to: "users#facebook_post"

  get "/settings/profile", to: "users#profile_form"
  get "/settings/password", to: "users#password_form"
  get "/settings/email", to: "users#email_form"
  get "/settings/social", to: "users#social_form"
  get "/settings/records", to: "users#records_form"

  post "/settings/profile", to: "users#update_profile"
  post "/settings/password", to: "users#update_password"
  post "/settings/email", to: "users#update_email"
  post "/settings/email/create", to: "users#create_email"

  post "/settings/social/disconnect_twitter", to: "users#disconnect_twitter"
  post "/settings/social/disconnect_facebook", to: "users#disconnect_facebook"
  
  get "/games/infinite_blocks", to: "infinite_blocks#home"
  get "/games/infinite_blocks/records", to: "infinite_blocks#records"
  get "/games/infinite_blocks/records/yearly", to: "infinite_blocks#records"
  get "/games/infinite_blocks/records/monthly", to: "infinite_blocks#records"
  get "/games/infinite_blocks/records/weekly", to: "infinite_blocks#records"

  post "/games/infinite_blocks/record", to: "infinite_blocks#record"
end
