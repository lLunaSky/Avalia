Rails.application.routes.draw do
  root "home#index"

  get "/login", to: "home#index"
  get "/create_login", to: "home#index"
  post "/create_login", to: "home#create_login"
  delete "/logout", to: "home#logout"

  get "/signup", to: "users#new", as: "new_user"
  post "/signup", to: "users#create"
end