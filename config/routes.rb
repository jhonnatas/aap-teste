Rails.application.routes.draw do
  devise_for :users do
    resources :registrations, only: %i[ index ]
  end
  resources :events do
    resources :registrations, only: %i[create destroy]

    member do
      get :registrations
    end
  end

  root "events#index"
end
