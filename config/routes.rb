# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    scope :v1 do
      resources :languages, only: [:index]
      resources :games, only: %i[index show create] do
        collection do
          get :active
          post '/active/attempts', to: 'games#create_attempt'
        end
      end
      resource :profile, only: %i[show update], controller: :users

      namespace :auth do
        post :register
        post :login
        post :logout
        post :refresh
      end
    end
  end

  root 'home#not_found'
  match '*path', to: 'home#not_found', via: :all
end
