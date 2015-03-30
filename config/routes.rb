Rails.application.routes.draw do
   devise_for :users, :skip => [:sessions]
  as :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'customers' => 'users#customer_list', :as => :customers
    post 'create_customer' => 'users#create_user', :as => :create_customer
    get 'change_status' => 'users#change_status', :as => :change_status
    get 'edit_customer' => 'users#edit_user', :as => :edit_customer
    put 'update_customer' => 'users#update_user', :as => :update_customer
    get 'agents' => 'users#agent_list', :as => :agents
    post 'create_agent' => 'users#create_user', :as => :create_agent
    get 'edit_agent' => 'users#edit_user', :as => :edit_agent
    post 'update_agent' => 'users#update_user', :as => :update_agent
    get 'delete_agent' => 'users#delete_user', :as => :delete_agent
    get 'dashboard' => 'users#dashboard', :as => :dashboard
    get 'edit_profile' => 'users#edit_profile', :as => :edit_profile
    put 'update_profile' => 'users#update_profile', :as => :update_profile
  end
  
#  devise_for :users,
#    controllers: {
#    registrations:  "users/registrations",
#    confirmations:  "users/confirmations",
#    sessions:       "users/sessions",
#    passwords:      "users/passwords",
#  }, :path_names => {:sign_in => "login", :sign_out => "logout"}
  
  as :vechile do
    get 'vehicle_list' => "vehicles#vehicle_list", :as => :vehicle_list
    post 'create_vehicle' => "vehicles#create_vehicle", :as => :create_vehicle
    put 'update_vehicle' => "vehicles#update_vehicle", :as => :update_vehicle
    get 'edit_vehicle' => "vehicles#edit_vehicle", :as => :edit_vehicle
    get 'destroy_vehicle' => "vehicles#destroy_vehicle", :as => :destroy_vehicle
  end
  
  as :route do
    get 'route_list' => "routes#route_list", :as => :route_list
    post 'create_route' => "routes#create_route", :as => :create_route
    put 'update_route' => "routes#update_route", :as => :update_route
    get 'edit_route' => "routes#edit_route", :as => :edit_route
    get 'destroy_route' => "routes#destroy_route", :as => :destroy_route
  end
  
  as :trip do
    get 'trip_list' => "trips#trip_list", :as => :trip_list
    post 'create_trip' => "trips#create_trip", :as => :create_trip
    put 'update_trip' => "trips#update_trip", :as => :update_trip
    get 'edit_trip' => "trips#edit_trip", :as => :edit_trip
    get 'destroy_trip' => "trips#destroy_trip", :as => :destroy_trip
    get 'stop_tracking_trip' => "trips#stop_tracking_trip", :as => :stop_tracking_trip
  end
  
  root :to => 'home#index'
  get '/user' => "home#index", :as => 'user'
  get '/validate_authentication' => "tracking#validate_authentication", :as => 'validate_authentication'
  get '/get_trip' => "tracking#get_trip", :as => 'get_trip'
  post '/save_position' => "tracking#save_position", :as => 'save_position'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
