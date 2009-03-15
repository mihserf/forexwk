ActionController::Routing::Routes.draw do |map|
  map.root :controller => "pages", :action => "home"
  map.resources :posts, :name_prefix => 'all_', :collection => { :search => :get }
  #map.resources :posts, :name_prefix => 'all_', :only=>[:get], :collection => { :search => :get }
	map.resources :forums, :topics, :posts, :monitorship

  %w(forum).each do |attr|
    map.resources :posts, :name_prefix => "#{attr}_", :path_prefix => "/#{attr.pluralize}/:#{attr}_id"
  end
  
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
      topic.resource :monitorship, :controller => :monitorships
    end
  end

  map.resources :private_messages

    
  map.resource :user_session
  #map.root :controller => "user_sessions", :action => "new"
  map.resources :searches
  map.resources :send_message, :only => :create
  
  map.resource :account, :controller => "users"
  map.resources :users, :collection => {:check_login => :get,:check_email => :get}, :member =>{:short_info => :get} do |user|
    user.resources :articles, :collection => {:per_rating => :get}
  end

  map.resources :password_resets

  map.resources :catalogues do |catalogue|
    catalogue.resources :articles, :collection => {:per_rating => :get}
  end


  map.resources :articles, :collection => {:per_rating => :get}, :has_many => :ratings do |article|
    article.resources :additions, :has_many => :ratings do |addition|
      addition.resources :comments
    end
  end

  map.resources :additions, :has_many => [:comments,:ratings]
  map.resources :comments

  map.resources :ratings
  
  map.resources :dealing_centers
  map.resources :books
  map.resources :videos
  map.resources :events
  map.resources :therms, :collection => [:search]

  map.resources :contests, :member => {:users => :get}, :collection => {:archive => :get}

  map.resources :trend_datas
  map.resources :currency_pairs, :has_many => [:trend_datas], :member => {:archive => :get}

  
  map.namespace :admin do |admin|
    admin.resources :pages
    admin.resources :catalogues
    admin.resources :users, :only => [:index,:destroy]
    admin.resources :dealing_centers
    admin.resources :contests, :member => {:finish => :get}
    admin.resources :therms
    admin.resources :queries
    admin.resources :videos
    admin.resources :books
    admin.resources :events
    admin.resources :articles
    admin.resources :article_indications, :only => [:create, :destroy]
    admin.resources :indications
    admin.resources :trend_datas, :has_many => :currency_datas, :member => {:download_data => :get}
    admin.resources :currency_datas
    admin.resources :trends
    admin.resources :currency_pairs
    admin.resources :currency_view_rules
    admin.resources :currency_pair_currency_view_rules, :only => [:create, :destroy]

  end

  map.with_options :controller => "pages" do |page|
    page.home "/", :action =>  "home"
    page.map ":id", :action => "show"
  end



  
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
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
