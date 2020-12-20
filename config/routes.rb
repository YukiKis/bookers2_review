Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  get 'books/edit'
  root "homes#home"
  get 'homes/about', as: "about"
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }
  resources :users, except: :destroy
  resources :books do
    resource :favorite, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
