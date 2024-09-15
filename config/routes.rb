Rails.application.routes.draw do
  devise_for :users
  resources :events do 
    resources :registrations, only: %i[create destroy]
  end
  
  root "events#index"
end
