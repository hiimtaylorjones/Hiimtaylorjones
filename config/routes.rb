require 'sidekiq/web'

Rails.application.routes.draw do

  resources :coffees
  devise_for :admins
  resources :posts

  namespace :api do 
    namespace :v1 do
      resources :posts, only: [:index] do
        get 'feedback', to: 'posts#feedback', as: :feedback 
      end
      post 'feedback/create', to: 'comments#create'
      resources :pages, only: [:index, :update]
    end
  end

  resources :pages, param: :title

  root 'basic_page#index'
  
  mount Sidekiq::Web => '/sidekiq'

  match '/about',             to: 'basic_page#about',             via: 'get'
  match '/writing',           to: 'basic_page#writing',           via: 'get'
  match '/speaking',          to: 'basic_page#speaking',          via: 'get'

  match '/admin',             to: 'basic_page#admin',             via: 'get'
  match '/blog',              to: 'posts#index',                  via: 'get'

  get '*path' => redirect { |p, req|
    req.flash[:notice] = "#{p[:path]} isn't a page on this site. Sorry!";
   '/'
  }
end
