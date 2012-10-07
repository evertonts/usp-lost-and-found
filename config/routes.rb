UspLostAndFound::Application.routes.draw do
  
  authenticated :user do
    root :to => 'home#index'
  end
  
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
  
  resources :messages
  resources :replies  
  
  resources :items do
    collection do
      get 'new_lost'
      get 'new_found'
      get 'search'
      get 'recover'
      get 'autocomplete_tag_name'
    end
  end
   
  get 'tags/:tag', :to => 'items#search', :as => :tag 
end

ActionDispatch::Routing::Translator.translate_from_file(
  'config/locales/routes.yml', {
    prefix_on_default_locale: false,
    keep_untranslated_routes: true })
 