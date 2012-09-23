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
      post 'search_lost'
      post 'search_found'
      get 'recover'
    end
  end
    
end

ActionDispatch::Routing::Translator.translate_from_file(
  'config/locales/routes.yml', {
    prefix_on_default_locale: false,
    keep_untranslated_routes: true })
