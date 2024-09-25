Rails.application.routes.draw do
  get "home/index"
  devise_for :users

  resources :events do
    resources :registrations, only: %i[create destroy]
    resources :activities do
      post "register", to: "activity_registrations#register"
    end

    member do
      get :registrations
    end
  end

  root "home#index"
end
