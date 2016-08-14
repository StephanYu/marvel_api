Rails.application.routes.draw do
  resources :comics, format: :json do
    member do
      put 'toggle'
    end

    collection do 
      get 'search', to: 'comics#search'
    end
  end
end
