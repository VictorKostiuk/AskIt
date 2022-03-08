# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :tags, only: :index
  end

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    resource :session, only: %i[new create destroy]
    resources :users, only: %i[new create update edit]

    resources :questions do
      resources :comments, only: %i[create destroy]

      resources :answers, except: %i[new show]
    end

    resources :answers, except: %i[new show] do
      resources :comments, only: %i[create destroy]
    end

    namespace :admin do
      resources :users, only: %i[index create edit update destroy]
    end

    root 'home#index'
  end
end
