Rails.application.routes.draw do
  
  devise_for :users

  
  resources :posts do 
    resources :comments
  end

  # You can have the root of your site routed with "root"
  root 'basic_page#index'
  match '/about',       to: 'basic_page#about',       via: 'get'
  match '/blog',        to: 'posts#index',            via: 'get'
  match '/admin',		    to: 'basic_page#admin_panel', via: 'get'
  match '/taylor',		  to: 'basic_page#taylor',	    via: 'get'
  match '/admin/blog',  to: 'posts#admin',            via: 'get'
end
