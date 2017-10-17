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
  end
  resources :reviews, only: [:index, :new, :create, :edit, :update] 
  resources :original_books do
  collection do
      get 'search'
    end
  end

  resources :shelved_books

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
