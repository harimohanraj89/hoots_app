Rails.application.routes.draw do
  root 'application#index'
  resources :hoots, only: [:index, :show, :create, :update, :destroy]
end
