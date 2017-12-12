Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :webhooks, only: [:create]
  resources :events, only: [:index]
  resources :setup, only: [:index]

  get "/ci" => "setup#ci"

  root to: "dashboard#index"

  get "login" => "sessions#new"
  get "logout" => "sessions#logout"
  get "/auth/:provider/callback" => "sessions#create"
end
