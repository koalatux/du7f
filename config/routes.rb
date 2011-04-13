ActionController::Routing::Routes.draw do |map|

  map.new_poll         'new',                            :controller => :polls,        :action => :new,     :conditions => { :method => :get    }
  map.polls            '',                               :controller => :polls,        :action => :index,   :conditions => { :method => :get    }
  map.polls            '',                               :controller => :polls,        :action => :create,  :conditions => { :method => :post   }
  map.edit_poll_admin  ':token/admin/:admin_token/edit', :controller => :polls,        :action => :edit,    :conditions => { :method => :get    }
  map.poll_admin       ':token/admin/:admin_token',      :controller => :polls,        :action => :update,  :conditions => { :method => :put    }
  map.poll_admin       ':token/admin/:admin_token',      :controller => :polls,        :action => :destroy, :conditions => { :method => :delete }

  map.poll             ':token',                         :controller => :participants, :action => :index,   :conditions => { :method => :get    }
  map.participants     ':token',                         :controller => :participants, :action => :create,  :conditions => { :method => :post   }
  map.edit_participant ':token/participant/:id/edit',    :controller => :participants, :action => :edit,    :conditions => { :method => :get    }
  map.participant      ':token/participant/:id',         :controller => :participants, :action => :update,  :conditions => { :method => :put    }
  map.participant      ':token/participant/:id',         :controller => :participants, :action => :destroy, :conditions => { :method => :delete }

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
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
