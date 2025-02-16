Rails.application.routes.draw do
  root "home#index"

  # Rotas de autenticação
  get "/login", to: "home#index"
  get "/create_login", to: "home#index"
  post "/create_login", to: "home#create_login"
  delete "/logout", to: "home#logout"

  # Rotas de cadastro
  get "/signup", to: "users#new", as: "new_user"
  post "/signup", to: "users#create"

  # Rotas de aprovação
  get 'pending_approvals', to: 'approvals#index', as: 'pending_approvals'
  post 'approve_user/:id', to: 'approvals#approve_user', as: 'approve_user'
  post 'reject_user/:id', to: 'approvals#reject_user', as: 'reject_user'
end