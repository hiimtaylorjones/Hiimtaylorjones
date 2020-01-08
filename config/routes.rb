Rails.application.routes.draw do

  devise_for :admins
  resources :posts do
    resources :comments do
      put "/approve",  to: "comments#approve", as: :approve
      post "/respond", to: "comments#respond", as: :respond
    end
    get "/comment_admin",  to: "posts#comment_admin", via: 'get'
  end

  namespace :api do 
    namespace :v1 do
      resources :posts, only: [:index] do
        get 'feedback', to: 'posts#feedback', as: :feedback 
      end
      post 'feedback/create', to: 'comments#create'
      get 'pages', to: 'pages#index'
    end
  end

  resources :pages, param: :title

  root 'basic_page#index'

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
