(in /Users/yann/Developpement/Rails/mdls)
Mdl::Application.routes.draw do
  match '' => 'menus#list', :as => :home
  match '/menus.rss' => 'menus#feedurl', :as => :menusrss
  resources :users
  resource :session
  resources :menus
  resources :menutype
  resources :plannings
  resource :comments
  match '/activate/:activation_code' => 'users#activate', :as => :activate, :activation_code => 
  match '/signup' => 'users#new', :as => :signup
  match '/forgot' => 'users#forgot', :as => :forgot
  match '/errors' => 'users#errors', :as => :errors
  match 'reset/:reset_code' => 'users#reset', :as => :reset
  match '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/profil' => 'profil#edit', :as => :profil
  match '/fr' => 'users#language', :as => :fr, :code => 'fr-FR'
  match '/en' => 'users#language', :as => :en, :code => 'en-US'
  match '/de' => 'users#language', :as => :de, :code => 'de-DE'
  match '/sp' => 'users#language', :as => :sp, :code => 'sp-SP'
  match '/menus-fb' => 'menus#feed', :as => :menusfb, :format => 'rss'
  match '/:controller(/:action(/:id))'
end
