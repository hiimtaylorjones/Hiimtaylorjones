Rails.application.routes.draw do

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
  
  match '/admin',   to: 'basic_page#admin',   via: 'get'
  match '/blog',    to: 'posts#index',        via: 'get'
  match '/refresh', to: 'basic_page#refresh', via: 'get'

  get '*path' => redirect { |p, req|
    req.flash[:notice] = "#{p[:path]} is unavailable";
   '/'
  }

  get "up" => "rails/health#show", as: :rails_health_check
end
