Rails.application.routes.draw do

  devise_for :admins
  resources :posts do
    resources :comments
  end

  root 'basic_page#index'
  match '/about',       to: 'basic_page#about',         via: 'get'
  match '/admin',       to: 'basic_page#admin',         via: 'get'
  match '/hire_me',     to: 'inquiries#new',            via: 'get'
  match '/blog',        to: 'posts#index',              via: 'get'

  get '*path' => redirect { |p, req|
    req.flash[:notice] = "#{p[:path]} isn't a page on this site. Sorry!";
   '/'
  }
end
