Brandishcv::Application.routes.draw do
  namespace :admin do
    resources :users
    resources :password_resets
    resources :cvs, only: [:show, :edit, :update]
    match 'signup' => 'signup#new', via: :get
    match 'signup' => 'signup#create', via: :post
    match 'login' => 'sessions#new', via: :get
    match 'login' => 'sessions#create', as: 'login'
    match 'logout' => 'sessions#destroy', as: 'logout'
    match "datatables/:action" => "datatables"
    match 'pages/:page' => 'pages#show'
  end

  root :to => 'home#index'

  match ':username' => 'cvs#show', as: 'show_cv'
  match ':username/edit' => 'cvs#edit', as: 'edit_cv'
  match ':username/update' => 'cvs#update', as: 'update_cv', only: :post

  match ':username/pdf' => 'pdf_exports#generate', as: 'export_pdf'
  match ':username/docx' => 'docx_exports#generate', as: 'export_docx'
end
