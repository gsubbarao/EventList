EventList::Application.routes.draw do
  root 'home#index'
  resources :sessions, :only => [:new, :create]
  resources :registerations, :only => [:new, :create, :destroy]
  resources :events, :only => [:new, :create, :destroy, :show] do
    member do
      get :attend_or_not
    end
  end
  get "home/index"
  get "/logout" => "sessions#destroy", :as => :logout
end
