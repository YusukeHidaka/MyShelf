Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:show, :edit, :update]
  resources :reviews
  resources :original_books

  root "welcome#index"
end
