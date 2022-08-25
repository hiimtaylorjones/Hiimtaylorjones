Rails.application.routes.draw do

  resources :coffees
  devise_for :admins, only: []
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
  
  match '/admin',             to: 'basic_page#admin',             via: 'get'
  match '/blog',              to: 'posts#index',                  via: 'get'

  get '*path' => redirect { |p, req|
    req.flash[:notice] = "#{p[:path]} isn't a page on this site. Sorry!";
   '/'
  }
end
