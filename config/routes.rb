Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :webhooks, only: [:create]
  resources :events, only: [:index]
  resources :dashboard, only: [:index]

  root to: "dashboard#index"
end
