Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :webhooks, only: [:create]
  resources :events, only: [:index]
  resources :dashboard, only: [:index]

  root to: "welcome#index"

  get "login" => "sessions#new"
  get "logout" => "sessions#logout"
  get "/auth/:provider/callback" => "sessions#create"
end
