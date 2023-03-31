Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :lists, only: [:index, :create], defaults: { format: :json }
      end

      resources :lists, only: [:update, :destroy], defaults: { format: :json } do
        resources :items, only: [:index, :show, :create, :update, :destroy], shallow: true, defaults: { format: :json }
      end
    end
  end
end

