Brandishcv::Application.routes.draw do
  namespace :admin do
    resources :users
    resources :password_resets
    resources :cvs, only: [:show, :edit, :update]
    get 'signup' => 'signup#new'
    post 'signup' => 'signup#create'
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    match 'logout' => 'sessions#destroy', as: 'logout', via: [:get, :delete]
    get "datatables/:action" => "datatables"
    get 'pages/:page' => 'pages#show'
  end

  root :to => 'home#index'

  get ':username' => 'cvs#show', as: 'show_cv'
  get ':username/edit' => 'cvs#edit', as: 'edit_cv'
  match ':username/update' => 'cvs#update', as: 'update_cv', via: [:post, :patch]

  get ':username/pdf' => 'pdf_exports#generate', as: 'export_pdf'
  get ':username/docx' => 'docx_exports#generate', as: 'export_docx'
  get ':username/markdown' => 'markdown_exports#generate', as: 'export_markdown'
end
