# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tickets, only: [:create]
    end
  end

  resources :tickets, only: [:index, :show]
  root "tickets#index"
end
