Rails.application.routes.draw do
  get '/', to: 'application#index'

  resources :merchants, only: [:show] do
    resources :dashboard, module: :merchant, only: [:index, :create]
    resources :items, module: :merchant
    resources :invoices, module: :merchant, only: [:index, :show, :update]
    resources :bulk_discounts, module: :merchant
  end

  resources :admin, only: [:index]
  namespace :admin do
    resources :invoices, except: [:new, :destroy]
    resources :merchants
  end
end
