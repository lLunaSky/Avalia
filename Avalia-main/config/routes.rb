Rails.application.routes.draw do
  resources :posts  # Define as rotas RESTful para posts
  root "posts#index"  # Página inicial será a lista de posts
end