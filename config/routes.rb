Rails.application.routes.draw do
  devise_for :users

  mount API::Base, at: "/"

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
    resources :comments, only: [:create, :destroy]
  end

  get :api_data, controller: :movies
end
