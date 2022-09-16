Rails.application.routes.draw do
  resources :merchants do
    resources :dashboards, only: [:index, :create]
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index]
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index, :show, :edit, :update]
  end
end
