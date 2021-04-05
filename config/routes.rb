Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  match '/products/merchant-products' => 'products#merchant_products', :as => "products_by_company_id", :via => "get"
  resources :products
  resources :companies

  resources :stories

  match '/merchant/login' => 'login#merchant_login', :as => "merchant_login", :via => "get"
  match '/merchant/login' => 'login#merchant_login_post', :as => "merchant_login_post", :via => "post"
  match '/merchant/logout' => 'login#merchant_logout', :as => "merchant_logout", :via => "get"
  match '/merchant/stories' => 'merchant#stories', :as => "merchant_stories", :via => "get"
  match '/merchant/index' => 'merchant#index', :as => 'merchant_index_path', :via => "get"
  resources :merchant


  match '/users/login' => 'login#user_login', :as => "user_login", :via => "get"
  match '/users/login' => 'login#user_login_post', :as => "user_login_post", :via => "post"
  match '/users/logout' => 'login#user_logout', :as => "user_logout", :via => "get"
  match '/users/likedlist/add' => 'users#add_to_likedlist', :as => "add_to_likedlist", :via => "post"
  match '/users/likedlist/delete' => 'users#delete_from_likedlist', :as => "delete_from_likedlist", :via => "post"
  match '/users/profile' => 'users#profile', :as => "user_profile", :via => "get"
  match '/users/wishlist/add' => 'users#add_to_wishlist', :as => "add_to_wishlist", :via => "post"
  match '/users/wishlist/delete' => 'users#delete_from_wishlist', :as => "delete_from_wishlist", :via => "post"
  match '/users/wishlist' => 'users#wishlist', :as => "user_wishlist", :via => "get"
  match '/users/wishlist/applicable-stores' => 'users#applicable_stores', :as => "applicable_stores", :via => "get"
  resources :users
  resources :posts


  
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
