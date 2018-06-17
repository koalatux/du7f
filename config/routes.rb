Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
