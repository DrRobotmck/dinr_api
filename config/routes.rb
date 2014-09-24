Rails.application.routes.draw do
  namespace :api do
    get 'violations' => 'violations#index'
    get 'actions' => 'actions#index'
  end
end
