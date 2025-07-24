Rails.application.routes.draw do
  resources :items
  resources :restaurants do
    member do
      get :dashboard
    end
    resources :dishes
    resources :orders
  end

  # Or, if you don't want top-level dishes/orders, remove the two lines below:
  resources :dishes
  resources :orders

  root "restaurants#index"  # or -> "restaurants#dashboard", id: 1 (custom controller action)
  get "up" => "rails/health#show", as: :rails_health_check
end
