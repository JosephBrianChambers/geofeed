Rails.application.routes.draw do
  get "/", to: "root#index"

  namespace :api do
    scope module: :v2, constraints: ApiVersion.new('v2') do
      resources :todos, only: :index
    end

    # Remember, non-default API versions have to be defined above the default version.
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'

      resources :todos do
        resources :items
      end

      resources :quotes, only: [:show]
    end
  end
end
