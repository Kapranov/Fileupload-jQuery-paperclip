Rails.application.routes.draw do
  resources :uploads
  root :to => 'uploads#index'
end
