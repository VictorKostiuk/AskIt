Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :update, :edit]

  resources :questions do
    resources :answers, except: [:new, :show]
  end

  root 'home#index'
end
