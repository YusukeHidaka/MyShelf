Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:index, :show, :edit, :update]
  resources :reviews
  resources :original_books do
  collection do
      get 'search'
    end
  end

  resources :shelved_books do
  collection do
      get '/:user_id/shelf', to: 'shelved_books#shelf'
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
