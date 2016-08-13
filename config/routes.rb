Rails.application.routes.draw do
  resources :comics, format: :json do
    member do
      put 'toggle'
    end
  end
end
