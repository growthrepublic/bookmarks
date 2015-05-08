Rails.application.routes.draw do
  root 'home#index'
  get 'list', to: 'home#list'

  namespace :api do
    resources :bookmarks do
      collection do
        get 'metadata'
        get 'search'
      end
    end
  end
end
