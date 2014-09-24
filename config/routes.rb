Rails.application.routes.draw do
  namespace :api do
    get 'violations' => 'violations#index'
    get 'actions' => 'actions#index'
    resources :restaurants, only: [:index]
  end
end
