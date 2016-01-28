Rails.application.routes.draw do

  get 'password_resets/new'

  resources :items do
    resources :comments
  end
  devise_for :users, controllers: {sessions: "users/sessions" }
  resources :password_resets
  resources :tags

  root 'resources#index'

    get   '/linkeditems/:id'                  => 'items#showlinks', as: :linkeditems
    post  '/item/:id/upvote'                  => 'items#upvote', as: :upvote
    post  '/item/:id/unvote'                  => 'items#unvote', as: :unvote
    post  '/item/:id/addtag'                  => 'items#addtag', as: :addtag
    get   '/item/:id/addtag'                  => 'items#edittags', as: :edittags
    post  '/item/:id/removetag'               => 'items#removetag', as: :removetag
    post  '/item/:id/updatetags'              => 'items#updatetags', as: :updatetags
    get   '/search'                           => 'resources#search', as: :search
    get   '/filter/:type/:tag/:order/(:item)' => 'resources#filter', as: :filter
    get   '/login'                            => 'application#authenticate_user!', as: :login
    get   '/sitesettings'                     => 'settings#index', as: :settings
    post  '/sitesettings/mergeTag'            =>  'settings#mergeTags', as: :mergetag

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
