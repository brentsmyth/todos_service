Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]

  namespace :api do
    namespace :v1 do
      resources :lists, only: [:index, :create, :update, :destroy], defaults: { format: :json } do
        resources :items, only: [:index, :create, :update, :destroy], shallow: true, defaults: { format: :json }
      end
    end
  end
end

