Rails.application.routes.draw do
  root 'home#index'
  get 'list', to: 'home#list'

  resources :bookmarks
end
