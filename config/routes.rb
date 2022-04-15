Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks do
    collection do 
      post :confirm
    end
  end
  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
