BwNewDev::Application.routes.draw do
  devise_for :admins

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :users
	resources :works, only: [:create, :update, :destroy] do
	end

	resources :pa_links, only: [ :index, :create, :destroy, :update ] do
	end

	match '/works/progress/:id', to: 'works#progress'

  resources :projects, only: [ :index, :new, :update, :create, :edit, :destroy ] do
    get :check_number, on: :collection
  end

  match '/projects/all', to: 'projects#all'
  match '/projects/amc', to: 'projects#amc'
  match '/projects/int', to: 'projects#int'
  match '/projects/wws', to: 'projects#wws'
  match '/projects/etc', to: 'projects#etc'
  match '/projects/working/:id', to: 'projects#working'
  match '/projects/export', to: 'projects#export'
  match '/projects/release', to: 'projects#release'
  get "sessions/logout"

  controller :sessions do
    get 'login' => :new
    post 'login' => :login
  end


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
   root :to => 'sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
