Rails.application.routes.draw do
  root "homes#home"
  get 'homes/about', as: "about"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, except: :destroy do
    resource :relationship, only: [:create, :destroy]
    member do
      get "/followers", to: "users#followers"
      get "/followings", to: "users#followings"
      get "/messages/:with_user_id", to: "messages#show", as: :message
      get "/messages", to: "messages#index"
      post "/messages/:with_user_id", to: "messages#create"
      delete "/messages/:message_id", to: "messages#destroy"
    end
  end
  post "/search/users", to: "users#search", as: :users_search
  post "/search/books", to: "books#search", as: :books_search
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
