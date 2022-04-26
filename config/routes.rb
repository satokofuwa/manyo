Rails.application.routes.draw do
  root "tasks#index"
 
  namespace :admin do
      resources :users
  end


 # resources :tasks do
  #  collection do 
   #   post :confirm
    #end
#  end
  resources :tasks
  resources :users,  only: [:new, :create, :show, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]


end
