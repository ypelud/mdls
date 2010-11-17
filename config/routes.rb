ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'menus'
  map.home '', :controller => 'menus', :action => 'index'
  

  map.resources :users do |user|
    user.resource :profil
  end
  
  map.resources :menus
  map.resources :menutypes
  map.resources :recherche

  map.resources :plannings
  map.resources :tags
  map.resources :comments

  map.resource :session
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  
  #match 'signup' => 'users#new'
  #match 'logout' => 'user_sessions#destroy'
  
  map.signup    '/signup',                    :controller => 'users',     :action => 'new'
  map.logout    '/logout',                    :controller => 'user_sessions',  :action => 'destroy'
    
#  map.activate  '/activate/:activation_code', :controller => 'users',     :action => 'activate', :activation_code => nil
#  map.forgot    '/forgot',                    :controller => 'users',     :action => 'forgot'
#  map.errors    '/errors',                    :controller => 'users',     :action => 'errors'
#  map.reset     'reset/:reset_code',          :controller => 'users',     :action => 'reset'
#  map.login     '/login',                     :controller => 'sessions',  :action => 'new'
#  map.profil    '/profil',                    :controller => 'profil',    :action => 'edit'
  
  map.menusrss  '/menus.rss',                 :controller => 'menus',     :action => 'feedurl'      
  map.menusfb   '/menus-fb',                  :controller => 'menus',     :action => 'feed',     :format => 'rss'

  map.fr        '/fr',                        :controller => 'users',     :action => 'language', :code => "fr-FR"
  map.en        '/en',                        :controller => 'users',     :action => 'language', :code => "en-US"
  map.de        '/de',                        :controller => 'users',     :action => 'language', :code => "de-DE"
  map.sp        '/sp',                        :controller => 'users',     :action => 'language', :code => "sp-SP"
  
  map.emailer   'emailer',                    :controller => 'emailer',  :action => 'index'
  
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
