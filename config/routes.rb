Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  
  resources :posts do 
    resources :comments
  end

  resources :pages

  root 'basic_page#index'
  match '/about',       to: 'basic_page#about',         via: 'get'
  match '/admin',       to: 'basic_page#admin',         via: 'get'
  match '/blog',        to: 'posts#index',              via: 'get'


end
