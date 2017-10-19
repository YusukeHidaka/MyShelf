Rails.application.routes.draw do
  get 'users/index'

  get 'users/show'

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:index, :show, :edit, :update] do
  collection do
      get '/:id/shelf', to: 'users#shelf', as: 'shelf'
      get '/:id/reviews', to: 'users#reviews', as: 'reviews'
    end
  member do
     get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :shelved_books, only: [:edit, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :reviews, only: [:index, :edit, :new, :create, :update, :destroy]
  resources :original_books, only: [:index, :create] do
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



# / → welcome:index ( only logged out user can visit here like landing page )
# │
# ├── reviews  => Tilme Line (root_path)
# │
# ├── users => User List (pending)
# │     │
# │     ├── /:id => Profile
# │     │    │
# │     │    ├── /reviews => One's Reviews
# │     │    │
# │     │    └── /shelf => One's Shelf
# │     │
# │     └── /search => User Search (pending)
# │
# ├── original_books
# │     │
# │     ├── /:id => Book Detail
# │     │
# │     └── /search => Book Search (AmazonAPI)
# │
# └── * => 404
