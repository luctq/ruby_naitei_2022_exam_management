Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    resources :subjects, only: %i(index)
    resources :users
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    namespace :admin do
      root to: "static_pages#index"
      resources :static_pages
      resources :profile, only: %i(edit update)
    end
  end
end
