Mdls::Application.routes.draw do
    match '' => 'menus#list', :as => :home
    match '/menus.rss' => 'menus#feedurl', :as => :menusrss
    
    resources :users
    resource :session
    resources :menus
    resources :menutype
    resources :plannings
    resource :comments
    
    match '/activate/:activation_code' => 'users#activate', :as => :activate #, :activation_code => 
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
    
    #a revoir
    match '/:controller(/:action(/:id))'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
