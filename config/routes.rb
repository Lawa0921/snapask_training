Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :courses
  resource :cart, only: [:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end
end
