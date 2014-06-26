Rails.application.routes.draw do
  
  devise_for :users

  
  resources :posts

  namespace :post do
    resources :comments
  end

  # You can have the root of your site routed with "root"
  root 'basic_page#index'
  match '/about',       to: 'basic_page#about',       via: 'get'
  match '/blog',        to: 'posts#index',            via: 'get'
  match '/about_taylor',to: 'basic_page#taylor_jones',via: 'get'
end
