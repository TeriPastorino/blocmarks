Rails.application.routes.draw do

  # without extra arguments
  # get 'controller/action' => controller_action_path helper
  # with a named helper
  # get 'contorller/action', as: :my_action
  # get 'path/to/somewhere', as: :somewhere, to: "controller#action"
  get 'my/bookmarks', as: :my_bookmarks, to: 'users#show'
  get 'my/likes', as: :liked_bookmarks, to: 'users#liked'


  devise_for :users
    resources :users, only: [:show]

  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:create, :destroy]
    end
  end

  

get 'welcome/index'
  get 'welcome/about' 
  root to: 'welcome#index'

    post :incoming, to: 'incoming#create'

#for modal bookmark update
get "bookmark/edit" => 'bookmark#edit', :as => :update


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
