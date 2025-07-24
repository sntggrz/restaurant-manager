Rails.application.routes.draw do
  root "restaurants#index"

  resources :items

  resources :restaurants do
    member { get :dashboard }
    resources :dishes
    resources :orders
  end

  resources :dishes
  resources :orders
end
