UspLostAndFound::Application.routes.draw do
  
  authenticated :user do
    root :to => 'home#index'
  end
  
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
  
  resources :messages
  
  resources :items do
    collection do
      get 'new_lost'
      get 'new_found'
      post 'search'
    end
  end
    
end
