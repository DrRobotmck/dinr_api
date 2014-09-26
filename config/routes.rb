Rails.application.routes.draw do
  namespace :api do
    get 'violations' => 'violations#index', defaults: {format: :json}
    get 'actions' => 'actions#index', defaults: {format: :json}
    resources :restaurants, only: [:index, :show], defaults: {format: :json}
  end
end
