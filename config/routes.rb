Rails.application.routes.draw do

  get "/", to: "home#top"
  get "/games", to: "home#games"
  get "/apps", to: "home#apps"
  get "/news", to: "home#news"
  get "/terms", to: "home#terms"
  get "/privacy", to: "home#privacy"
  get "/contact", to: "home#contact"

  get "/mypage", to: "users#mypage"
  get "/users/:id", to: "users#show"
  get "/login" , to: "users#login_form"
  get "/signup", to: "users#signup_form"

  get "/games/infinite_blocks", to: "infinite_blocks#home"
  get "/games/infinite_blocks/records", to: "infinite_blocks#records"
end
