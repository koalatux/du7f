Rails.application.routes.draw do
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

  get    'new',                               to: 'polls#new',                    as: :new_poll
  get    '',                                  to: 'polls#index',                  as: :polls
  post   '',                                  to: 'polls#create'
  get    ':token/admin/:admin_token/edit',    to: 'polls#edit',                   as: :edit_poll_admin
  patch  ':token/admin/:admin_token',         to: 'polls#update',                 as: :poll_admin
  get    ':token/admin/:admin_token/destroy', to: 'polls#destroy_confirm',        as: :destroy_poll_admin
  delete ':token/admin/:admin_token',         to: 'polls#destroy'

  get    ':token',                            to: 'participants#index',           as: :poll
  post   ':token',                            to: 'participants#create',          as: :participants
  get    ':token/participant/:id/edit',       to: 'participants#edit',            as: :edit_participant
  patch  ':token/participant/:id',            to: 'participants#update',          as: :participant
  get    ':token/participant/:id/destroy',    to: 'participants#destroy_confirm', as: :destroy_participant
  delete ':token/participant/:id',            to: 'participants#destroy'

  post   ':token/comment',                    to: 'comments#create',              as: :comments
  #get    ':token/comment/:id/edit',           to: 'comments#edit',                as: :edit_comment
  #patch  ':token/comment/:id',                to: 'comments#update',              as: :comment
  get    ':token/comment/:id/destroy',        to: 'comments#destroy_confirm',     as: :destroy_comment
  delete ':token/comment/:id',                to: 'comments#destroy',             as: :comment

end
