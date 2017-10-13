Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:show, :edit, :update]
  resources :reviews
  resources :original_books do
  collection do
      get 'search'
    end
  end

  devise_scope :user do
    authenticated :user do
      root :to => 'reviews#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => "welcome#index", as: :unauthenticated_root
    end
  end
end
