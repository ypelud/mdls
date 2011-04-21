Mdls::Application.routes.draw do
  
  match '/auth/:provider/callback' => 'authentications#create' 
  
  resources :authentications

    #map.root :controller => 'menus'
    #map.home '', :controller => 'menus', :action => 'index'
    root :to => "menus#index"
    

    resources :users do 
      resource :profil
    end


    resources :menus
    resources :menutypes
    resources :recherche
    
    resources :plannings
    resources :tags
    resources :comments
    
    resource :session
    
    resource :user_session
    resource :account, :controller => "users"

    match 'signup' => 'users#new'
    match 'logout' => 'user_sessions#destroy'

  #  map.activate  '/activate/:activation_code', :controller => 'users',     :action => 'activate', :activation_code => nil
  #  map.forgot    '/forgot',                    :controller => 'users',     :action => 'forgot'
  #  map.errors    '/errors',                    :controller => 'users',     :action => 'errors'
  #  map.reset     'reset/:reset_code',          :controller => 'users',     :action => 'reset'
  #  map.login     '/login',                     :controller => 'sessions',  :action => 'new'
  #  map.profil    '/profil',                    :controller => 'profil',    :action => 'edit'

    match 'menus.rss' => 'menus#feedurl'      
    match 'menus-fb' => 'menus#feed', :format => 'rss'

    match 'fr' => 'users#language', :code => "fr"
    match 'en' => 'users#language', :code => "en-US"
    match 'de' => 'users#language', :code => "de"
    match 'es' => 'users#language', :code => "es"

    match 'emailer' => 'emailer#index'

  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
  match ':lang/:controller(/:action(/:id(.:format)))'
end
