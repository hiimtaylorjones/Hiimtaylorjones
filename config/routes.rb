Rails.application.routes.draw do

  devise_for :admins
  resources :posts
  # resources :pages, param: :title

  root 'basic_page#refresh'
  
  # match '/admin',   to: 'basic_page#admin',   via: 'get'
  # match '/blog',    to: 'posts#index',        via: 'get'
  # match '/refresh', to: 'basic_page#refresh', via: 'get'

  get '*path' => redirect { |p, req|
    req.flash[:notice] = "#{p[:path]} is unavailable";
   '/'
  }

  get "up" => "rails/health#show", as: :rails_health_check
end
