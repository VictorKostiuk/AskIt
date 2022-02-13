Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  resources :questions do
    resources :answers, except: [:new, :show]
  end

  root 'home#index'
end
