Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  
  resources :posts do 
    resources :comments
  end

  root 'basic_page#index'
  match '/about',       to: 'basic_page#about',       via: 'get'
  match '/blog',        to: 'posts#index',            via: 'get'
  match '/blog/admin',  to: 'posts#admin',            via: 'get'
end
