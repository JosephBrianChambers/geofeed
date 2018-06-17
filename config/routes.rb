Rails.application.routes.draw do
  resources :bubbles
  get "/", to: "root#index"
  get '/auth/:provider/callback', to: 'api/v1/authentication#authenticate_from_oauth'

  namespace :api do
    scope module: :v2, constraints: ApiVersion.new('v2') do
      resources :todos, only: :index
    end

    # Remember, non-default API versions have to be defined above the default version.
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'

      resource :users, only: [:show]

      resources :todos do
        resources :items
      end

      resources :quotes, only: [:show]

      resources :events, only: [:create, :show] do
        member do
          get "fetch_content"
        end
      end
    end
  end

  get "*path", to: "root#index", constraints: lambda { |r| !(r.path =~ /api/) }
end
