Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:show, :edit, :update]
  resources :reviews, only: [:index]
  # resources :reviews, only: [:index, :show, :edit, :update]

  root "welcome#index"
end
