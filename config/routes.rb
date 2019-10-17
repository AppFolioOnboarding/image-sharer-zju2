Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#home'
  root 'images#index'
  resources :images, only: [:new, :create, :show, :index]
end
