Rails.application.routes.draw do
  root "home#index"

  resources :teams, only: [:index, :show]
end
