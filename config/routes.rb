Brandishcv::Application.routes.draw do
  namespace :admin do
    resources :users
    resources :cvs
    match 'signup' => 'signup#new', via: :get, as: 'signup'
    match 'signup' => 'signup#create', via: :post, as: 'signup'
    match 'login' => 'sessions#new', via: :get
    match 'login' => 'sessions#create', as: 'login'
    match 'logout' => 'sessions#destroy', as: 'logout'
  end

  root :to => 'home#index'

  match ':username' => 'cvs#show', as: 'show_cv'
  match ':username/edit' => 'cvs#edit', as: 'edit_cv'
  match ':username/update' => 'cvs#update', as: 'update_cv', only: :post
end
