Rails.application.routes.draw do
  devise_for :users

  resources :events do
    resources :registrations, only: %i[create destroy]
    resources :activities

    member do
      get :registrations
    end
  end

  root "events#index"
end
