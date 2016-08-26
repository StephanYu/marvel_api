Rails.application.routes.draw do
  resources :comics, only: [:index, :show], format: :json do
    member do
      post 'vote'
    end

    collection do 
      get 'search', to: 'comics#search'
    end
  end
end
