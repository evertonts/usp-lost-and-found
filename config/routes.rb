UspLostAndFound::Application.routes.draw do
  
  authenticated :user do
    root :to => 'home#index'
  end
  
  root :to => "home#index"
  devise_for :users
  resources :users do 
    collection do
      get 'show'
      get 'index'
    end
  end
  
  match "messages/mark_as_read/:item_id", :controller => :messages, :action => 'mark_as_read', :via => :get
  match "replies/mark_as_read/:message_id", :controller => :replies, :action => 'mark_as_read', :via => :get
  
  
  resources :messages
  resources :replies  
  
  resources :items do
    collection do
      get 'new_lost'
      get 'new_found'
      get 'search'
      get 'recover'
      get 'autocomplete_tag_name'
      get 'tag'
      get 'recovered'
    end
  end
   
  get 'tags/:tag', :to => 'items#tag', :as => :tag 
  
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
end

ActionDispatch::Routing::Translator.translate_from_file(
  'config/locales/routes.yml', {
    prefix_on_default_locale: false,
    keep_untranslated_routes: true })
 