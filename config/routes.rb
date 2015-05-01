# du7f - a simple web app for simple polls
# Copyright (C) 2011  Adrian Friedli <adi@koalatux.ch>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


Du7f::Application.routes.draw do
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
  # match ':controller(/:action(/:id))(.:format)'

  get    'new',                               to: 'polls#new',                    as: :new_poll
  get    '',                                  to: 'polls#index',                  as: :polls
  post   '',                                  to: 'polls#create',                 as: :polls
  get    ':token/admin/:admin_token/edit',    to: 'polls#edit',                   as: :edit_poll_admin
  put    ':token/admin/:admin_token',         to: 'polls#update',                 as: :poll_admin
  get    ':token/admin/:admin_token/destroy', to: 'polls#destroy_confirm',        as: :destroy_poll_admin
  delete ':token/admin/:admin_token',         to: 'polls#destroy',                as: :poll_admin

  get    ':token',                            to: 'participants#index',           as: :poll
  post   ':token',                            to: 'participants#create',          as: :participants
  get    ':token/participant/:id/edit',       to: 'participants#edit',            as: :edit_participant
  put    ':token/participant/:id',            to: 'participants#update',          as: :participant
  get    ':token/participant/:id/destroy',    to: 'participants#destroy_confirm', as: :destroy_participant
  delete ':token/participant/:id',            to: 'participants#destroy',         as: :participant

  post   ':token/comment',                    to: 'comments#create',              as: :comments
  #get    ':token/comment/:id/edit',           to: 'comments#edit',                as: :edit_comment
  #put    ':token/comment/:id',                to: 'comments#update',              as: :comment
  get    ':token/comment/:id/destroy',        to: 'comments#destroy_confirm',     as: :destroy_comment
  delete ':token/comment/:id',                to: 'comments#destroy',             as: :comment

end
