Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :courses
  resources :purchased_courses, only: [:index]
  resource :cart, only: [:show, :destroy, :create] do
    collection do
      post :add, path:'add/:id'
    end
  end
  mount ApiRoot => ApiRoot::PREFIX
end
