Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :api_keys, path: 'api-keys', only: %i[index create destroy]
  
  namespace :api do
    namespace :v1 do
      resources :forecast, only: :index
      resources :users, only: :create
    end
  end
end
