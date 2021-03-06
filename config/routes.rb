Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'sessions/new' => 'sessions#new', as: "log_in"
  post 'sessions' => 'sessions#create'
  delete 'sessions' => 'sessions#destroy', as: "log_out"

  get 'admin/dashboard', to: 'admin#dashboard', as: 'admin_dashboard'
  get 'admin/preview', to: 'admin#preview', as: 'admin_preview'

  namespace :admin do
    resources :categories
    
    get 'categories/:parent_id/children', to: 'categories#index', as: 'child_categories'
    get 'categories/:parent_id/children/new', to: 'categories#new', as: 'new_child_category'
    post 'categories/:parent_id/children', to: 'categories#create', as: nil
    
    resources :products

    get 'products/:product_id/images', to: 'images#index', as: 'images'
    get 'products/:product_id/images/new', to: 'images#new', as: 'new_image'
    post 'products/:product_id/images', to: 'images#create', as: nil
    delete 'images/:id', to: 'images#destroy', as: 'image'
    
    resources :orders, only: [:index, :show]
  end

  get 'products', to: 'products#index', as: 'products'
  get 'products/:id', to: 'products#show', as: 'product', constraints: { id: /\d+/ }
  
  post 'basket/items', to: 'basket_items#create', as: nil
  delete 'basket/items/:product_id', to: 'basket_items#destroy', as: nil
  
  resources :orders, only: [:new, :create, :show]

  get '*slug', to: 'products#index'

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
