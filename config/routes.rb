Rails.application.routes.draw do

  # default_url_options :host => "'http://localhost:3000"

  devise_for :users
  # match '/users/:id/destroy', to: 'users#destroy', via: [:get, :patch], as: 'signout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  resources :users do
    collection do
      post 'add_user'
    end
    member do
      put  'update_user'
    end
  end

  resources :events do
    collection do
      get 'band'
    end
  end

  root to:'users#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
    
      resources :users, only:[] do
        collection do
          post 'login'
        end
      end
      
      resources :events, only: [] do
        collection do
          post 'create_event'
          post 'off_sync'
          get 'event_list'
          get 'show_event'
          get 'sync_events'
          post 'edit_event'
        end
      end
    end
  end
end
