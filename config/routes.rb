Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  resources :posts, only: %i[new create edit update destroy] do
    resources :comments, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]
  resources :users, only: [:show, :index]
  resources :likes, only: %i[create destroy]
end
