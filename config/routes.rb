Rails.application.routes.draw do
  namespace :api do
    # Violation routing
    get 'violations' => 'violations#index', defaults: {format: :json}
    # Action routing
    get 'actions' => 'actions#index', defaults: {format: :json}
    # Restaurant routing
    get 'restaurants/by_camis' => 'restaurants#by_camis',
      defaults: {format: :json},
      as: 'camis'
    resources :restaurants, only: [:index, :show], defaults: {format: :json}
  end
end
