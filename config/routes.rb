Cmwp::Application.routes.draw do
  resources :users do
    get 'usersettings', :on => :member
  end
  resources :roles
  resources :userpositions
  resources :workflows
  resources :workflowhistories
  resources :systemtasklogs
  # resources :months
  resources :notices do
    get 'read', :on => :collection
    get 'unread', :on => :collection
  end
  resources :massages do
    get 'read', :on => :collection
    get 'unread', :on => :collection
  end
  resources :custs do
    get 'productcusts_index', :on => :collection
    get 'cust_detail_index', :on => :collection
  end
  resources :products do
    member do
      get :downloadfile
    end
  end
  resources :brokerteammodifies do
    get 'accept', :on => :member
    get 'deny', :on => :member
  end
  resources :brokerproductrels, :only => [:create, :destroy]
  resources :brokerfavcusts, :only => [:create, :destroy]
  resources :channels
  resources :subchannels
  resources :channelurls do
    collection do
      get 'get_brokers', to: "channelurls#get_brokers"
      get 'get_subchannels', to: "channelurls#get_subchannels"
    end
  end
  resources :workflowunderways do
    resources :workflow_steps, :custservvisits
  end
  # resources :workflow_steps
  resources :sessions, :only => [:new, :create, :destroy]
  resources :recoverypasswords do
    get 'confirm', :on => :collection
  end
  resources :departments, :only => [:index, :show] do
    resources :deptindices do
      get 'dept_index', :on => :member
    end
  end
  resources :branches, :only => [:index, :show] do
    get 'typebrokers', :on => :member
    resources :branchindices do
      get 'branch_index', :on => :member
    end
  end
  resources :brokers, :only => [:index, :show] do
    resources :brokerindices do
      get 'broker_index', :on => :member
    end
    resources :salaries do
      get 'broker_salary', :on => :member
    end
    member do
      get :relbrokers
    end
  end
  resources :categories do
    get 'search', :on => :collection
  end

  root :to => 'pages#home'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  # match '/pwd',     :to => 'recoverypassword#new'

  # scope :protocol => 'https://', :constraints => { :protocol => 'https://' } do
  #   resources :sessions
  # end


  # match 'categories' => 'categories#show', :via => :get

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
  # match ':controller(/:action(/:id(.:format)))'
end
